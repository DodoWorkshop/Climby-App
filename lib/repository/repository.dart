import 'package:http/http.dart' as http;

abstract class HttpRepository<T extends http.BaseClient> {
  final T client;

  HttpRepository(this.client);
}