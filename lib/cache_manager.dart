library cache_manager;

import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class CacheManager {
  Database? _db;
  late StoreRef<String, String> _cacheStore; // Store JSON strings

  CacheManager() {
    _cacheStore = StoreRef.main(); // Store strings instead of Map<String, dynamic>
  }

  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocumentDir.path}/cache.db';
    _db = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> setCache(String key, dynamic value,
      {Duration duration = const Duration(hours: 1)}) async {
    if (_db == null) await init();

    final expiryTime = DateTime.now().add(duration).toIso8601String();
    final cacheValue = {
      'data': jsonEncode(value), // Store data as JSON string
      'expiry': expiryTime,
    };

    await _cacheStore.record(key).put(_db!, jsonEncode(cacheValue)); // Store as JSON
  }

  Future<dynamic> getCache(String key) async {
    if (_db == null) await init();

    final cacheValueJson = await _cacheStore.record(key).get(_db!);
    if (cacheValueJson == null) {
      return null;
    }

    final Map<String, dynamic> cacheValue = jsonDecode(cacheValueJson);
    final expiryTime = DateTime.parse(cacheValue['expiry'] as String);
    if (DateTime.now().isAfter(expiryTime)) {
      await _cacheStore.record(key).delete(_db!);
      return null;
    }

    // Return decoded data
    return jsonDecode(cacheValue['data']);
  }

  Future<void> deleteCache(String key) async {
    if (_db == null) await init();

    await _cacheStore.record(key).delete(_db!);
  }

  Future<void> clearAllCache() async {
    await init();
    await _cacheStore.delete(_db!);
  }
}
