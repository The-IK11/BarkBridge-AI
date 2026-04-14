import 'package:rxdart/rxdart.dart';
import 'package:tintpin14_app/networks/api_clint/post/enum.dart';
import 'package:tintpin14_app/networks/api_clint/post/rx.dart';
import 'package:tintpin14_app/networks/endpoints.dart';

// PostOnboardingRx postOnboardingRX = PostOnboardingRx(
//   empty: {},
//   dataFetcher: BehaviorSubject<Map>(),
// );

// ============ Auth - Registration ============

PostRx postRegister = PostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  endPoint: Endpoints.postRegister(),
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
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
  toastSetting: ToastSetting.error,
  onSuccess: (data) async {
    // Social login successful
  },
  onError: (message) async {
    // Error message will be displayed automatically via toast
  },
);
