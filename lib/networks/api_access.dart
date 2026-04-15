import 'package:rxdart/rxdart.dart';
import 'package:tintpin14_app/networks/api_clint/delete/enum.dart';
import 'package:tintpin14_app/networks/api_clint/delete/rx.dart';
import 'package:tintpin14_app/networks/api_clint/post/enum.dart';
import 'package:tintpin14_app/networks/api_clint/post/rx.dart';
import 'package:tintpin14_app/networks/api_clint/get/rx.dart';
import 'package:tintpin14_app/networks/endpoints.dart';
import 'package:tintpin14_app/feature/profile/model/profile_model.dart';

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
    // OTP verified successfully for registration
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
    // User login successful
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
    // Social login successful
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);

// ============ User Profile ============

GetRx<GetProfileDataModel> getUser = GetRx<GetProfileDataModel>(
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
