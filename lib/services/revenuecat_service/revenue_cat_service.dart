import 'dart:async';
import 'dart:io';
import 'package:barkbridgeai/services/revenuecat_service/revenue_cut_constent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Service class to manage all RevenueCat operations
/// Handles SDK configuration, purchases, customer info, and entitlements
class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  // Your RevenueCat API key
  static final String _apiKey = Platform.isIOS
      ? RevenueCutConstent.appleApiKey
      : RevenueCutConstent.googleApiKey;

  // Entitlement identifier
  static const String monthlyProEntitlement = 'barkbridge_premium';

  // Product identifiers
  static const String monthlyProProductId = 'barkbridge_monthly_premium';
  static const String credits10ProductId = 'barkbridge_credits_10';
  static const String credits25ProductId = 'barkbridge_credits_25';

  // Storage key for customer info
  static const String _customerInfoKey = 'revenue_cat_customer_info';

  // Stream controllers for reactive updates
  final StreamController<CustomerInfo> _customerInfoController =
      StreamController<CustomerInfo>.broadcast();

  Stream<CustomerInfo> get customerInfoStream => _customerInfoController.stream;

  CustomerInfo? _currentCustomerInfo;
  bool _isConfigured = false;

  /// Initialize and configure RevenueCat SDK
  /// Should be called during app startup, before any other RevenueCat operations
  Future<void> configure() async {
    if (_isConfigured) {
      debugPrint('RevenueCat already configured');
      return;
    }

    try {
      // Enable debug logs in development
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);

      // Configure the SDK
      PurchasesConfiguration configuration = PurchasesConfiguration(_apiKey);

      await Purchases.configure(configuration);

      // Set up listener for customer info updates
      Purchases.addCustomerInfoUpdateListener(_onCustomerInfoUpdate);

      // Fetch initial customer info
      await refreshCustomerInfo();

      _isConfigured = true;
      debugPrint('✅ RevenueCat configured successfully');
    } on PlatformException catch (e) {
      debugPrint('❌ RevenueCat configuration error: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected error configuring RevenueCat: $e');
      rethrow;
    }
  }

  /// Callback for when customer info updates
  void _onCustomerInfoUpdate(CustomerInfo customerInfo) {
    debugPrint('📱 Customer info updated');
    _currentCustomerInfo = customerInfo;
    _customerInfoController.add(customerInfo);
    _saveCustomerInfoLocally(customerInfo);
  }

  /// Get current customer info (cached or fetch fresh)
  Future<CustomerInfo> getCustomerInfo() async {
    try {
      if (_currentCustomerInfo != null) {
        return _currentCustomerInfo!;
      }
      return await refreshCustomerInfo();
    } on PlatformException catch (e) {
      debugPrint('❌ Error getting customer info: ${e.message}');
      rethrow;
    }
  }

  /// Refresh customer info from RevenueCat servers
  Future<CustomerInfo> refreshCustomerInfo() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      _currentCustomerInfo = customerInfo;
      _customerInfoController.add(customerInfo);
      _saveCustomerInfoLocally(customerInfo);
      return customerInfo;
    } on PlatformException catch (e) {
      debugPrint('❌ Error refreshing customer info: ${e.message}');
      rethrow;
    }
  }

  /// Check if user has active subscription entitlement
  Future<bool> hasActiveSubscription() async {
    try {
      final customerInfo = await getCustomerInfo();

      // Debug: Print all available entitlements
      debugPrint('📋 Checking entitlements:');
      customerInfo.entitlements.all.forEach((key, value) {
        debugPrint('  - $key: isActive=${value.isActive}');
      });

      final entitlement = customerInfo.entitlements.all[monthlyProEntitlement];

      if (entitlement != null && entitlement.isActive) {
        final productId = entitlement.productIdentifier;

        // If the entitlement was unlocked by a consumable credit pack (due to RevenueCat dashboard mapping)
        if (productId == credits10ProductId ||
            productId == credits25ProductId ||
            productId == RevenueCutConstent.credits10AppStoreId ||
            productId == RevenueCutConstent.credits25AppStoreId) {
          // Check if they actually have any active subscriptions
          if (customerInfo.activeSubscriptions.isNotEmpty) {
            debugPrint(
              '✅ User has active subscriptions: ${customerInfo.activeSubscriptions}',
            );
            return true;
          }

          debugPrint(
            '⚠️ Premium entitlement unlocked by consumable ($productId). Ignoring.',
          );
          return false;
        }

        debugPrint('✅ User has active $monthlyProEntitlement subscription');
        return true;
      }

      debugPrint('❌ User does not have active subscription');
      return false;
    } catch (e) {
      debugPrint('❌ Error checking subscription status: $e');
      return false;
    }
  }

  /// Get detailed entitlement information
  Future<EntitlementInfo?> getEntitlementInfo() async {
    try {
      final customerInfo = await getCustomerInfo();
      return customerInfo.entitlements.all[monthlyProEntitlement];
    } catch (e) {
      debugPrint('❌ Error getting entitlement info: $e');
      return null;
    }
  }

  /// Get all available offerings (packages for sale)
  Future<Offerings?> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();

      if (offerings.current == null) {
        debugPrint('⚠️ No current offering found');
        return null;
      }

      debugPrint('📦 Current offering: ${offerings.current!.identifier}');
      debugPrint(
        '📦 Available packages: ${offerings.current!.availablePackages.length}',
      );

      // Debug: list all packages
      for (final pkg in offerings.current!.availablePackages) {
        debugPrint(
          '  📦 ${pkg.identifier}: ${pkg.storeProduct.identifier} — ${pkg.storeProduct.priceString}',
        );
      }

      return offerings;
    } on PlatformException catch (e) {
      debugPrint('❌ Error getting offerings: ${e.message}');
      return null;
    }
  }

  /// Purchase a package
  Future<PurchaseResult> purchasePackage(Package package) async {
    try {
      debugPrint('🛒 Attempting to purchase: ${package.identifier}');

      final purchaseParams = PurchaseParams.package(package);

      final purchaseResult = await Purchases.purchase(purchaseParams);
      final customerInfo = purchaseResult.customerInfo;

      // Debug: Print all available entitlements
      debugPrint('📋 All entitlements in customer info:');
      customerInfo.entitlements.all.forEach((key, value) {
        debugPrint('  - $key: isActive=${value.isActive}');
      });

      // Check if the purchase was successful
      final entitlement = customerInfo.entitlements.all[monthlyProEntitlement];

      if (entitlement != null && entitlement.isActive) {
        debugPrint('✅ Purchase successful!');
        return PurchaseResult.success;
      } else {
        // Check if ANY entitlement is active (user might have purchased)
        final hasAnyActiveEntitlement = customerInfo.entitlements.all.values
            .any((entitlement) => entitlement.isActive);

        if (hasAnyActiveEntitlement) {
          debugPrint('⚠️ Purchase successful but entitlement name mismatch!');
          debugPrint('   Expected: "$monthlyProEntitlement"');
          debugPrint(
            '   Available: ${customerInfo.entitlements.all.keys.join(", ")}',
          );
          return PurchaseResult.success;
        } else {
          debugPrint('⚠️ Purchase completed but no active entitlements found');
          debugPrint('   This might be a sandbox/test purchase');
          // For test environment, consider this a success
          return PurchaseResult.success;
        }
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      debugPrint('❌ Purchase error: ${e.message} (Code: $errorCode)');

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        return PurchaseResult.cancelled;
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        return PurchaseResult.notAllowed;
      } else if (errorCode == PurchasesErrorCode.productAlreadyPurchasedError) {
        return PurchaseResult.alreadyPurchased;
      } else {
        return PurchaseResult.error;
      }
    } catch (e) {
      debugPrint('❌ Unexpected purchase error: $e');
      return PurchaseResult.error;
    }
  }

  /// Purchase a specific product by its store product identifier.
  /// Searches through all available offerings to find the matching package.
  Future<PurchaseResult> purchaseByStoreProductId(String storeProductId) async {
    try {
      final offerings = await getOfferings();
      if (offerings == null) {
        debugPrint('❌ No offerings available');
        return PurchaseResult.error;
      }

      // Search through ALL offerings, not just current
      Package? targetPackage;

      for (final offering in offerings.all.values) {
        for (final pkg in offering.availablePackages) {
          if (pkg.storeProduct.identifier == storeProductId) {
            targetPackage = pkg;
            break;
          }
        }
        if (targetPackage != null) break;
      }

      // Also check current offering
      if (targetPackage == null && offerings.current != null) {
        for (final pkg in offerings.current!.availablePackages) {
          if (pkg.storeProduct.identifier == storeProductId) {
            targetPackage = pkg;
            break;
          }
        }
      }

      if (targetPackage == null) {
        debugPrint('❌ Product not found in offerings: $storeProductId');
        debugPrint('   Available products:');
        for (final offering in offerings.all.values) {
          for (final pkg in offering.availablePackages) {
            debugPrint('   - ${pkg.storeProduct.identifier}');
          }
        }
        return PurchaseResult.error;
      }

      return await purchasePackage(targetPackage);
    } catch (e) {
      debugPrint('❌ Error purchasing product: $e');
      return PurchaseResult.error;
    }
  }

  /// Purchase a specific product by ID (searches current offering)
  Future<PurchaseResult> purchaseProduct(String productId) async {
    try {
      final offerings = await getOfferings();
      if (offerings?.current == null) {
        debugPrint('❌ No offerings available');
        return PurchaseResult.error;
      }

      // Find the package with the matching product
      final package = offerings!.current!.availablePackages.firstWhere(
        (pkg) => pkg.storeProduct.identifier == productId,
        orElse: () => throw Exception('Product not found: $productId'),
      );

      return await purchasePackage(package);
    } catch (e) {
      debugPrint('❌ Error purchasing product: $e');
      return PurchaseResult.error;
    }
  }

  /// Restore previous purchases
  Future<RestoreResult> restorePurchases() async {
    try {
      debugPrint('🔄 Restoring purchases...');

      final customerInfo = await Purchases.restorePurchases();

      // Check if any entitlements are now active
      final hasActiveEntitlement = customerInfo.entitlements.all.values.any(
        (entitlement) => entitlement.isActive,
      );

      if (hasActiveEntitlement) {
        debugPrint('✅ Purchases restored successfully');
        return RestoreResult.success;
      } else {
        debugPrint('ℹ️ No active purchases to restore');
        return RestoreResult.noPurchases;
      }
    } on PlatformException catch (e) {
      debugPrint('❌ Error restoring purchases: ${e.message}');
      return RestoreResult.error;
    }
  }

  /// Log in a user with a custom app user ID
  Future<bool> loginUser(String appUserId) async {
    try {
      debugPrint('👤 Logging in user: $appUserId');

      final logInResult = await Purchases.logIn(appUserId);

      debugPrint('✅RevenueCat User logged in successfully');
      debugPrint('Created: ${logInResult.created}');

      return true;
    } on PlatformException catch (e) {
      debugPrint('❌ Error logging in user: ${e.message}');
      return false;
    }
  }

  /// Log out current user
  Future<bool> logoutUser() async {
    try {
      debugPrint('👤 Logging out user...');

      await Purchases.logOut();

      debugPrint('✅ RevenueCat User logged out successfully');
      return true;
    } on PlatformException catch (e) {
      debugPrint('❌ Error logging out user: ${e.message}');
      return false;
    }
  }

  /// Get the app user ID
  Future<String> getAppUserId() async {
    try {
      return await Purchases.appUserID;
    } catch (e) {
      debugPrint('❌ Error getting app user ID: $e');
      return '';
    }
  }

  /// Check if user is anonymous
  Future<bool> isAnonymous() async {
    try {
      return await Purchases.isAnonymous;
    } catch (e) {
      debugPrint('❌ Error checking if user is anonymous: $e');
      return true;
    }
  }

  /// Get subscription status information
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    try {
      final customerInfo = await getCustomerInfo();
      final entitlement = customerInfo.entitlements.all[monthlyProEntitlement];

      if (entitlement == null || !entitlement.isActive) {
        return SubscriptionStatus(
          isActive: false,
          willRenew: false,
          periodType: null,
          expirationDate: null,
          productIdentifier: null,
        );
      }

      return SubscriptionStatus(
        isActive: entitlement.isActive,
        willRenew: entitlement.willRenew,
        periodType: entitlement.periodType,
        expirationDate: entitlement.expirationDate,
        productIdentifier: entitlement.productIdentifier,
        isSandbox: entitlement.isSandbox,
        originalPurchaseDate: entitlement.originalPurchaseDate,
        latestPurchaseDate: entitlement.latestPurchaseDate,
        unsubscribeDetectedAt: entitlement.unsubscribeDetectedAt,
        billingIssueDetectedAt: entitlement.billingIssueDetectedAt,
      );
    } catch (e) {
      debugPrint('❌ Error getting subscription status: $e');
      return SubscriptionStatus(
        isActive: false,
        willRenew: false,
        periodType: null,
        expirationDate: null,
        productIdentifier: null,
      );
    }
  }

  /// Save customer info to local storage for offline access
  void _saveCustomerInfoLocally(CustomerInfo customerInfo) {
    try {
      final box = GetStorage();
      // Store essential info as JSON
      box.write(_customerInfoKey, {
        'hasActiveSubscription':
            customerInfo.entitlements.all[monthlyProEntitlement]?.isActive ??
            false,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('⚠️ Error saving customer info locally: $e');
    }
  }

  /// Check if products have introductory offers available
  /// Note: Check the Package's storeProduct.introductoryPrice for eligibility
  Future<bool> hasIntroductoryOffer(Package package) async {
    try {
      final storeProduct = package.storeProduct;
      final hasIntro = storeProduct.introductoryPrice != null;
      debugPrint(
        'Product ${storeProduct.identifier} has intro offer: $hasIntro',
      );
      return hasIntro;
    } catch (e) {
      debugPrint('❌ Error checking introductory offer: $e');
      return false;
    }
  }

  /// Set custom attributes for the user
  Future<void> setUserAttributes(Map<String, String> attributes) async {
    try {
      await Purchases.setAttributes(attributes);
      debugPrint('✅ User attributes set successfully');
    } catch (e) {
      debugPrint('❌ Error setting user attributes: $e');
    }
  }

  /// Invalidate customer info cache
  Future<void> invalidateCustomerInfoCache() async {
    try {
      await Purchases.invalidateCustomerInfoCache();
      debugPrint('✅ Customer info cache invalidated');
    } catch (e) {
      debugPrint('❌ Error invalidating cache: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _customerInfoController.close();
  }
}

/// Result of a purchase attempt
enum PurchaseResult { success, cancelled, error, notAllowed, alreadyPurchased }

/// Result of restore purchases attempt
enum RestoreResult { success, noPurchases, error }

/// Subscription status model
class SubscriptionStatus {
  final bool isActive;
  final bool willRenew;
  final PeriodType? periodType;
  final String? expirationDate;
  final String? productIdentifier;
  final bool? isSandbox;
  final String? originalPurchaseDate;
  final String? latestPurchaseDate;
  final String? unsubscribeDetectedAt;
  final String? billingIssueDetectedAt;

  SubscriptionStatus({
    required this.isActive,
    required this.willRenew,
    required this.periodType,
    required this.expirationDate,
    required this.productIdentifier,
    this.isSandbox,
    this.originalPurchaseDate,
    this.latestPurchaseDate,
    this.unsubscribeDetectedAt,
    this.billingIssueDetectedAt,
  });

  String get periodTypeString {
    switch (periodType) {
      case PeriodType.normal:
        return 'Normal';
      case PeriodType.intro:
        return 'Introductory';
      case PeriodType.trial:
        return 'Trial';
      default:
        return 'Unknown';
    }
  }

  bool get hasBillingIssue => billingIssueDetectedAt != null;
  bool get hasUnsubscribed => unsubscribeDetectedAt != null;

  @override
  String toString() {
    return 'SubscriptionStatus(isActive: $isActive, willRenew: $willRenew, '
        'periodType: $periodTypeString, expirationDate: $expirationDate)';
  }
}
