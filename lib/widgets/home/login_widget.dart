import 'package:flutter/material.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/widgets/home/pulsingbar_widget.dart';

class LoginWidget extends StatelessWidget {
  final VoidCallback doLogin;
  final MyPosition myPosition;

  const LoginWidget({
    super.key,
    required this.doLogin,
    required this.myPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: doLogin,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8),
                  Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              // 2. 버튼이 눌리면 부모에게서 받은 함수를 실행합니다.
              onPressed: doLogin,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8),
                  Text(
                    'Sign in with Apple',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Hero(
              tag: 'pulse',
              child: SizedBox(height: 50, child: const PulsingBarWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
