import 'package:climby/util/log_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  late http.Client _client;
  late String _baseUrl;

  String? _token;

  ApiClient() {
    _client = http.Client();
    _baseUrl = dotenv.env['CLIMBY_API_BASE_URL']!;
  }

  set token(String? token) {
    _token = token;
    LogUtils.log("Token set: $_token");
  }

  String? getToken() => _token;

  Map<String, String> _getDefaultHeaders() {
    return {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest baseRequest) {
    if (_token == null) {
      throw UnimplementedError(
          "A token should be provided in order to access Climby API");
    }

    final url = Uri.parse(_baseUrl + baseRequest.url.toString());

    LogUtils.log("${baseRequest.method} - $url");

    if (baseRequest is http.Request) {
      final newRequest = http.Request(baseRequest.method, url)
        ..headers.addAll(baseRequest.headers)
        ..headers.addAll(_getDefaultHeaders())
        ..bodyBytes = baseRequest.bodyBytes
        ..encoding = baseRequest.encoding;

      return _client.send(newRequest).then(
        (val) {
          LogUtils.log("${baseRequest.method} - $url: ${val.statusCode}");
          return val;
        },
        onError: (e) {
          LogUtils.log(
              "${baseRequest.method} - $url: ${e.statusCode} -> ${e.toString()}");
          return e;
        },
      );
    } else {
      throw UnimplementedError("Request type not implemented");
    }
  }
}
