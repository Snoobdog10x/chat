import 'package:chat/abstract/abstract_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CacheKey { LOCAL_USER }

class LocalStorageService extends AbstractService {
  SharedPreferences? _storage;
  Future<bool> setCache(CacheKey key, String value) async {
    if (_storage == null) return false;
    return await _storage!.setString(key.name, value);
  }

  Future<bool> clearCache() async {
    if (_storage == null) return false;
    return await _storage!.clear();
  }

  String getCache(CacheKey key) {
    if (_storage == null) return "";
    return _storage!.getString(key.name) ?? "";
  }

  Future<bool> removeCache(CacheKey key) async {
    if (_storage == null) return false;
    return await _storage!.remove(key.name);
  }

  @override
  Future<void> boot() async {
    if (_storage != null) return;
    print("boot");
    _storage = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {}
}
