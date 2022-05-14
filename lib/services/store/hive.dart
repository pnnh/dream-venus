import 'dart:io';

import 'package:dream/services/store/adapters/task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheStore<K, V> extends HiveStore {
  CacheStore(String store) : super(store);

  Future<V?> getValue(K key) async {
    var value = await super.get<K, V>(key);
    return value;
  }

  Future<void> putValue(K key, V value) async {
    await super.put(key, value);
  }

  Future<List<V>> queryValues() async {
    var values = await super.query<V>();
    return values.toList();
  }
}

class HiveStore {
  String store;

  HiveStore(this.store);

  static Future<void> init() async {
    Directory current = Directory.current;
    debugPrint('current: ${current.path}');
    await Hive.initFlutter('store');
    Hive.registerAdapter(TaskAdapter());
  }

  Future<V?> get<K, V>(K key) async {
    var box = await Hive.openBox<V>(store);

    return box.get(key);
  }

  Future<void> put<K, V>(K key, V value) async {
    var box = await Hive.openBox<V>(store);
    return box.put(key, value);
  }

  Future<Iterable<V>> query<V>() async {
    var box = await Hive.openBox<V>(store);
    return box.values;
  }
}
