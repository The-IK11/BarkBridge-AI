// ignore_for_file: constant_identifier_names

const String url = "https://thedonstarke.thewarriors.team";

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
}
