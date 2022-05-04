import 'dart:ffi';

abstract class Service<T> {
  List<T> all = [];
  late String baseUrl;

  T? get(int id);

  Future<T?> load(int id);
  Future<List<T>> loadAll([bool refresh = false]);
  Future<T> create(T value);
  Future<T> edit(T value);
  Future<Void> delete(T value);
  Future<T?> getOrLoad(int id);
  T addIfNotExist(T t);
}
