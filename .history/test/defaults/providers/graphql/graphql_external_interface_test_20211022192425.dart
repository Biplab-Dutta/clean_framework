import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {}

class GraphQLServiceFake extends Fake implements GraphQLService {
  Map<String, dynamic> _json;

  set response(Map<String, dynamic> newJson) => _json = newJson;

  GraphQLServiceFake(this._json);

  @override
  Future<Map<String, dynamic>> request(
      {required GraphQLMethod method,
      required String document,
      Map<String, dynamic>? variables}) async {
    if (_json.isEmpty) throw 'service exception';
    return _json;
  }
}
