import 'package:flutter/material.dart';
import 'package:radio_together/widgets/home/logins/social_login.dart';

class GoogleButtonWidget extends StatelessWidget with SocialLogin {
  final VoidCallback onPressed;

  const GoogleButtonWidget({required this.onPressed});

  @override
  void login() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1F2937), // gray-900
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Logo SVG
            SizedBox(
              width: 24,
              height: 24,
              child: CustomPaint(painter: _GoogleLogoPainter()),
            ),
            SizedBox(width: 12),
            Text(
              'Google로 계속하기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Google 로고 커스텀 페인터
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Blue part
    paint.color = Color(0xFF4285F4);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.94, size.height * 0.51)
        ..lineTo(size.width * 0.94, size.height * 0.51),
      paint,
    );

    // You can add more detailed Google logo paths here
    // Or use flutter_svg package to load an SVG
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
