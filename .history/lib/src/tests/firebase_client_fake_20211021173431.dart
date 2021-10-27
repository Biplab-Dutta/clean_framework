import 'dart:async';

import 'package:clean_framework/src/defaults/providers/firebase/firebase_client.dart';

class FirebaseClientFake implements FirebaseClient {
  final Map<String, dynamic> content;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();

  FirebaseClientFake(this.content);

  @override
  Future<void> delete(
      {required String path, required String id, BatchKey? batchKey}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> read(
      {required String path, required String id}) async {
    return content;
  }

  @override
  Future<Map<String, dynamic>> readAll({required String path}) async {
    return content;
  }

  @override
  Future<void> update(
      {required String path,
      required Map<String, dynamic> content,
      required String id,
      BatchKey? batchKey}) {
    throw UnimplementedError();
  }

  @override
  Stream<Map<String, dynamic>> watch(
      {required String path, required String id}) {
    Future.delayed(Duration(seconds: 1), () => _controller.sink.add(content));
    return _controller.stream;
  }

  @override
  Stream<Map<String, dynamic>> watchAll({required String path}) {
    Future.delayed(Duration(seconds: 1), () => _controller.sink.add(content));
    return _controller.stream;
  }

  @override
  Future<String> write(
          {required String path,
          required Map<String, dynamic> content,
          String? id,
          BatchKey? batchKey}) async =>
      'id';

  @override
  void createQuery(String path, SnapshotQuery<Map<String, dynamic>> query) {}

  @override
  clearQuery() {}

  void dispose() {
    _controller.close();
  }
}
