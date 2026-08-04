// import 'package:flutter/foundation.dart';
// import 'package:get_storage/get_storage.dart';

// /// Global credits manager using ValueNotifier for reactive UI updates.
// /// For testing purposes, credits are stored locally via GetStorage.
// class CreditsManager {
//   CreditsManager._internal();
//   static final CreditsManager instance = CreditsManager._internal();

//   static const String _creditsKey = 'scan_credits';
//   static const String _isFirstInstallKey = 'credits_first_install';
//   static const int _freeCredits = 3;

//   /// Reactive notifier — listen to this in widgets via ValueListenableBuilder.
//   final ValueNotifier<int> creditsNotifier = ValueNotifier<int>(0);

//   /// Current scan credits count.
//   int get scanCredits => creditsNotifier.value;

//   /// Whether the user has credits available.
//   bool get hasCredits => creditsNotifier.value > 0;

//   /// Initialize the credits manager.
//   /// Grants 3 free credits on first install.
//   void init() {
//     final box = GetStorage();
//     final bool isFirstInstall = box.read(_isFirstInstallKey) ?? true;

//     if (isFirstInstall) {
//       // First install — grant free credits
//       creditsNotifier.value = _freeCredits;
//       box.write(_creditsKey, _freeCredits);
//       box.write(_isFirstInstallKey, false);
//       debugPrint('🎁 Granted $_freeCredits free scan credits (first install)');
//     } else {
//       creditsNotifier.value = box.read(_creditsKey) ?? 0;
//       debugPrint(
//         '📊 Loaded ${creditsNotifier.value} scan credits from storage',
//       );
//     }
//   }

//   /// Add credits after a successful purchase.
//   void addCredits(int amount) {
//     creditsNotifier.value += amount;
//     _persist();
//     debugPrint('➕ Added $amount credits. Total: ${creditsNotifier.value}');
//   }

//   /// Set credits to an exact value (used for monthly subscription reset).
//   void setCredits(int amount) {
//     creditsNotifier.value = amount;
//     _persist();
//     debugPrint('🔄 Set credits to $amount');
//   }

//   /// Use one credit (for a scan). Returns false if no credits available.
//   bool useCredit() {
//     if (!hasCredits) {
//       debugPrint('❌ No scan credits available');
//       return false;
//     }
//     creditsNotifier.value -= 1;
//     _persist();
//     debugPrint('🔬 Used 1 credit. Remaining: ${creditsNotifier.value}');
//     return true;
//   }

//   void _persist() {
//     try {
//       GetStorage().write(_creditsKey, creditsNotifier.value);
//     } catch (e) {
//       debugPrint('⚠️ Error persisting credits: $e');
//     }
//   }
// }
