import 'dart:io';

import 'package:clean_framework_example/core/pokemon/pokemon_external_interface.dart';
import 'package:clean_framework_example/core/pokemon/pokemon_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  var interface = PokemonExternalInterface();

  group('PokemonExternalInterface tests |', () {
    test('get request success', () async {
      final dio = DioMock();

      when(
        () => dio.get<Map<String, dynamic>>(
          'pokemon',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'name': 'pikachu'},
          requestOptions: RequestOptions(path: 'pokemon'),
        ),
      );

      interface = PokemonExternalInterface(dio: dio);

      final result = await interface.request(TestPokemonRequest());

      expect(result.isRight, isTrue);
      expect(result.right.data, equals({'name': 'pikachu'}));
    });

    test('get request failure', () async {
      final dio = DioMock();

      when(
        () => dio.get<Map<String, dynamic>>(
          'pokemon',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(HttpException('No Internet'));

      interface = PokemonExternalInterface(dio: dio);

      final result = await interface.request(TestPokemonRequest());

      expect(result.isLeft, isTrue);
      expect(
        result.left.message,
        equals(HttpException('No Internet').toString()),
      );
    });
  });
}

class TestPokemonRequest extends GetPokemonRequest {
  @override
  String get resource => 'pokemon';
}

class DioMock extends Mock implements Dio {}
