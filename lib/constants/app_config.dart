enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  static Environment _environment = Environment.development;

  static Environment get environment => _environment;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  static String get appName {
    switch (_environment) {
      case Environment.development:
        return 'Yugayo Dev';
      case Environment.staging:
        return 'Yugayo Staging';
      case Environment.production:
        return 'Yugayo';
    }
  }

  static String get baseUrl {
    switch (_environment) {
      case Environment.development:
        return 'https://dev-api.yugayo.com';
      case Environment.staging:
        return 'https://staging-api.yugayo.com';
      case Environment.production:
        return 'https://api.yugayo.com';
    }
  }

  static bool get isDebug => _environment != Environment.production;

  static bool get enableLogging => _environment == Environment.development;
}
