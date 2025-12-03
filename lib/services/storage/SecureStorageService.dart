import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;
  static const String ACCESS_TOKEN = "accessToken";
  static const String REFRESH_TOKEN = "refreshToken";

  SecureStorageService(this._storage);

  // AccessToken 저장
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: ACCESS_TOKEN, value: token);
  }

  // AccessToken 읽기
  Future<String?> getAccessToken() async {
    return await _storage.read(key: ACCESS_TOKEN);
  }

  // RefreshToken 저장
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: REFRESH_TOKEN, value: token);
  }

  // RefreshToken 읽기
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: REFRESH_TOKEN);
  }

  // 모든 토큰 제거 (로그아웃용)
  Future<void> clearTokens() async {
    await _storage.delete(key: ACCESS_TOKEN);
    await _storage.delete(key: REFRESH_TOKEN);
  }

  // 필요하면 전체 삭제
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
