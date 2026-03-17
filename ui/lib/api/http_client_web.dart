import 'package:connectrpc/connect.dart';
import 'package:connectrpc/web.dart' as connect_web;

HttpClient createClient() {
  return connect_web.createHttpClient();
}
