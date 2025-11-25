import 'package:flutter/material.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/widgets/home/logins/apple_button_widget.dart';
import 'package:radio_together/widgets/home/logins/google_button_widget.dart';
import 'package:radio_together/widgets/home/logo_widget.dart';

class LoginButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final MyPosition? myPosition;

  const LoginButtonWidget({
    super.key,
    required this.onPressed,
    required this.myPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo & Branding
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  LogoWidget(),
                  SizedBox(height: 32),
                  Text(
                    '가치 있는 라디오',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '친구와 소통하며 듣는 라디오',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                ],
              ),
            ),

            // myPosition 값에 따라 로그인 버튼 또는 로딩 인디케이터를 보여줍니다.
            (myPosition != null)
                ? Column(
                    children: [
                      GoogleButtonWidget(onPressed: onPressed),
                      SizedBox(height: 12),
                      AppleButtonWidget(onPressed: onPressed),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text.rich(
                          TextSpan(
                            text: '계속 진행하면 ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                text: '서비스 약관',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' 및 '),
                              TextSpan(
                                text: '개인정보 처리방침',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: '에 동의하는 것으로 간주됩니다.'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64.0),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
          ],
        ),
      ),
    );
  }
}
