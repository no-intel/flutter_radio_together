import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;

class GoogleLoginService {
  final String clientId;
  final String authorizationEndpoint;
  final String tokenEndpoint;
  final String redirectUrl;
  final String backendTokenEndpoint;
  final FlutterAppAuth appauth;

  GoogleLoginService({
    required this.clientId,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.redirectUrl,
    required this.backendTokenEndpoint,
    required this.appauth,
  });

  Future<void> getCode() async {
    try {
      AuthorizationServiceConfiguration authorizationServiceConfiguration =
          AuthorizationServiceConfiguration(
            authorizationEndpoint: authorizationEndpoint,
            tokenEndpoint: tokenEndpoint,
          );

      // AuthorizationRequest: authorize()는 PKCE를 내부관리해 authorizationCode만 반환
      final AuthorizationResponse? result = await appauth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUrl,
          serviceConfiguration: authorizationServiceConfiguration,
          scopes: ['openid', 'email', 'profile'],
          // 요청 파라미터: offline access(리프레시 토큰)과 동의 강제
          additionalParameters: {'access_type': 'offline'},
          promptValues: ['consent'],
        ),
      );

      if (result == null) {
        return;
      }

      final String? authorizationCode = result.authorizationCode;
      // 일부 환경에서는 codeVerifier를 result.codeVerifier에서 얻을 수 있음.
      // flutter_appauth의 authorize()는 내부 PKCE를 관리하므로 codeVerifier가 null일 수 있음.
      final String? codeVerifier = result.codeVerifier;

      // 서버로 전송: code와 redirect_uri(및 가능하면 code_verifier)를 보낸다.
      final response = await http.post(
        Uri.parse(backendTokenEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': authorizationCode,
          'redirect_uri': redirectUrl,
          // code_verifier가 있다면 같이 보내기 (서버가 교환 방식에 따라 필요할 수 있음)
          if (codeVerifier != null) 'code_verifier': codeVerifier,
        }),
      );

      if (response.statusCode == 200) {
        // 서버가 자체 JWT나 세션 정보를 응답으로 준다면 여기서 처리
        final body = jsonDecode(response.body);
        // 예: body['access_token'] (server JWT), body['expires_in'] 등
      } else {}
    } catch (e, st) {
      print(st);
    }
  }
}
