/// Central API configuration holding base URLs and timeouts.
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://mock-api.calleyacd.com/api';
  static const Duration timeout = Duration(seconds: 15);
}
