import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:radio_together/services/create/get_radio_item.dart';
import 'package:radio_together/services/home/auth/google_login.dart';
import 'package:radio_together/services/home/get_position_service.dart';
import 'package:radio_together/services/storage/SecureStorageService.dart';

// Helper function to safely get environment variables
String _getEnv(String key) {
  final value = dotenv.env[key];
  if (value == null || value.isEmpty) {
    throw Exception('$key is not set in the .env file');
  }
  return value;
}

final getPositionServiceProvider = Provider<GetPositionService>((ref) {
  return GetPositionService();
});

final getRadioItemsServiceProvider = Provider<GetRadioItemsService>((ref) {
  return GetRadioItemsService();
});

final getGoogleLoginServiceProvider = Provider<GoogleLoginService>((ref) {
  // ✨ 해결책: 웹 클라이언트 ID 대신, 원래의 안드로이드용 클라이언트 ID를 사용합니다.
  final clientId = _getEnv('GOOGLE_CLIENT_ID');
  final authorizationEndpoint = _getEnv(
    'ANDROID_GOOGLE_AUTHORIZATION_ENDPOINT',
  );
  final tokenEndpoint = _getEnv('TOKEN_ENDPOINT');
  final redirectUrl = _getEnv('REDIRECT_URL');
  final backendTokenEndpoint = _getEnv('BACKEND_TOKEN_ENDPOINT');
  final appauth = FlutterAppAuth();

  return GoogleLoginService(
    clientId: clientId,
    authorizationEndpoint: authorizationEndpoint,
    tokenEndpoint: tokenEndpoint,
    redirectUrl: redirectUrl,
    backendTokenEndpoint: backendTokenEndpoint,
    appauth: appauth,
    secureStorage: ref.watch(getSecureStorageServiceProvider),
  );
});

final getSecureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(FlutterSecureStorage());
});
