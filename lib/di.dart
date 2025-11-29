import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/services/create/get_radio_item.dart';
import 'package:radio_together/services/home/auth/google_login.dart';
import 'package:radio_together/services/home/get_position_service.dart';

final getPositionServiceProvider = Provider<GetPositionService>((ref) {
  return GetPositionService();
});

final getRadioItemsServiceProvider = Provider<GetRadioItemsService>((ref) {
  return GetRadioItemsService();
});

final getGoogleLoginServiceProvider = Provider<GoogleLoginService>((ref) {
  String clientId = dotenv.env['GOOGLE_CLIENT_ID']!;
  String authorizationEndpoint = dotenv.env['GOOGLE_AUTHORIZATION_ENDPOINT']!;
  String tokenEndpoint = dotenv.env['GOOGLE_TOKEN_ENDPOINT']!;
  String redirectUrl = dotenv.env['GOOGLE_REDIRECT_URL']!;
  String backendTokenEndpoint = dotenv.env['BACKEND_TOKEN_ENDPOINT']!;
  FlutterAppAuth appauth = FlutterAppAuth();

  return GoogleLoginService(
    clientId: clientId,
    authorizationEndpoint: authorizationEndpoint,
    tokenEndpoint: tokenEndpoint,
    redirectUrl: redirectUrl,
    backendTokenEndpoint: backendTokenEndpoint,
    appauth: appauth,
  );
});
