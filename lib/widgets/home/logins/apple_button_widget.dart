import 'package:flutter/material.dart';
import 'package:radio_together/widgets/home/logins/social_login.dart';

class AppleButtonWidget extends StatelessWidget with SocialLogin {
  final VoidCallback onPressed;

  const AppleButtonWidget({super.key, required this.onPressed});

  @override
  void login() {
    // TODO: implement login
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.apple, size: 24),
            SizedBox(width: 12),
            Text(
              'Apple로 계속하기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
