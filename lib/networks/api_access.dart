import 'package:rxdart/rxdart.dart';
import 'package:barkbridgeai/constants/app_constants.dart';
import 'package:barkbridgeai/feature/dynamic_page/model/dynamic_page_model.dart';
import 'package:barkbridgeai/helpers/di.dart';
import 'package:barkbridgeai/networks/api_clint/delete/enum.dart';
import 'package:barkbridgeai/networks/api_clint/delete/rx.dart';
import 'package:barkbridgeai/networks/api_clint/post/enum.dart';
import 'package:barkbridgeai/networks/api_clint/post/rx.dart';
import 'package:barkbridgeai/networks/api_clint/get/rx.dart';
import 'package:barkbridgeai/networks/dio/dio.dart';
import 'package:barkbridgeai/networks/endpoints.dart';
import 'package:barkbridgeai/feature/profile/model/profile_model.dart';
import 'package:barkbridgeai/feature/profile/model/ai_response_model.dart';
import 'package:barkbridgeai/feature/faqAndTermsOfService/model/faq_screen_model.dart';

// PostOnboardingRx postOnboardingRX = PostOnboardingRx(
//   empty: {},
//   dataFetcher: BehaviorSubject<Map>(),
// );

// ============ Auth - Registration ============

PostRx postRegister = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postRegister(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // User registration successful
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postRegisterOtpResend = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postRegisterOtpResend(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // OTP resent successfully for registration
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postRegisterOtpVerify = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postRegisterOtpVerify(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    if (data['data'] != null && data['data']['token'] != null) {
      DioSingleton.instance.update(data['data']['token']);
      await appData.write(kKeyAccessToken, data['data']['token']);
      await appData.write(kKeyIsLoggedIn, true);
    }
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ Auth - Login ============

PostRx postLogin = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postLogin(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    if (data['data'] != null && data['data']['token'] != null) {
      DioSingleton.instance.update(data['data']['token']);
      await appData.write(kKeyAccessToken, data['data']['token']);
      await appData.write(kKeyIsLoggedIn, true);
    }
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postLoginEmailVerify = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postLoginEmailVerify(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // Email verified successfully for login
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ Auth - Forgot Password ============

PostRx postLoginResetPassword = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postLoginResetPassword(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // Password reset initiated successfully
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postLoginOtpResend = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postLoginOtpResend(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // OTP resent successfully for password reset
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postLoginOtpVerify = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postLoginOtpVerify(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // OTP verified successfully for password reset
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ Auth - Social Login ============

PostRx postSocialLogin = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postSocialLogin(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    if (data['data'] != null && data['data']['token'] != null) {
      DioSingleton.instance.update(data['data']['token']);
      await appData.write(kKeyAccessToken, data['data']['token']);
      await appData.write(kKeyIsLoggedIn, true);
    }
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ User Profile ============

GetRx<GetProfileDataModel> getUserData = GetRx<GetProfileDataModel>(
  empty: GetProfileDataModel(),
  dataFetcher: BehaviorSubject<GetProfileDataModel>(),
  endpoint: Endpoints.getUserData(),
  fromJson: GetProfileDataModel.fromJson,
);

PostRx postUpdateUser = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postUpdateUserData(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // User updated successfully
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

DeleteRx postDeleteAccount = DeleteRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  deleteEndPoint: Endpoints.postDeleteAccount(),
  toastSetting: DeleteToastSetting.both,
  onSuccess: (data) async {
    DioSingleton.instance.reset();
    await appData.write(kKeyAccessToken, null);
    await appData.write(kKeyIsLoggedIn, false);
    // Account deleted successfully
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postLogout = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postLogout(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // Logout successful

    DioSingleton.instance.reset();
    await appData.write(kKeyAccessToken, null);
    await appData.write(kKeyIsLoggedIn, false);
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

PostRx postUpdatePassword = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postUpdatePassword(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // Password updated successfully
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ Pet Analysis ============

// Reactive variable to store the AI analysis response
BehaviorSubject<AIResponseModel?> aiResponseSubject =
    BehaviorSubject<AIResponseModel?>.seeded(null);

PostRx postPetAnalyze = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postPetAnalyze(),
  toastSetting: ToastSetting.both,
  onSuccess: (data) async {
    // Pet analyze successful - store response
    if (data != null) {
      try {
        final aiResponse = AIResponseModel.fromJson(data);
        aiResponseSubject.add(aiResponse);
      } catch (e) {
        print('Error parsing AI response: $e');
      }
    }
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ FAQ ============

GetRx<FaqScreenModel> getFaqRx = GetRx<FaqScreenModel>(
  empty: FaqScreenModel(),
  dataFetcher: BehaviorSubject<FaqScreenModel>(),
  endpoint: Endpoints.getFaq(),
  fromJson: FaqScreenModel.fromJson,
);

// ============ Dynamic Page ============
GetRx<DynamicPageModel> getDynamicPageRx = GetRx<DynamicPageModel>(
  empty: DynamicPageModel(),
  dataFetcher: BehaviorSubject<DynamicPageModel>(),
  fromJson: DynamicPageModel.fromJson,
);
