// ignore_for_file: constant_identifier_names

const String url = "https://tintpin.thewarriors.team/api";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) => "";
}

final class Endpoints {
  Endpoints._();

  static String getSkinCalculate(String guestId) =>
      "/api/calculate-score${guestId.isNotEmpty ? '?guest_id=$guestId' : ''}";
  static String postAnalysis() => "/api/face-analysis";
  static String postProductRecommended() => "/api/recommend-products";
  static String postAiChat() => "/api/chat";
  static String getAIChat(String id) => "/api/history?guest_id=$id";

  // Auth - Registration
  static String postRegister() => "/users/register";
  static String postRegisterOtpResend() => "/users/register/otp-resend?";
  static String postRegisterOtpVerify() => "/users/register/otp-verify";

  // Auth - Login
  static String postLogin() => "/users/login";
  static String postLoginEmailVerify() => "/users/login/email-verify";

  // Auth - Forgot Password
  static String postLoginResetPassword() => "/users/login/reset-password";
  static String postLoginOtpResend() => "/users/login/otp-resend";
  static String postLoginOtpVerify() => "/users/login/otp-verify";

  // Auth - Social Login
  static String postSocialLogin() => "/social-login";
}
