import 'package:flutter/material.dart';
import 'package:radio_together/widgets/pulsingbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(136, 157, 159, 1),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/radio-main.png', fit: BoxFit.cover),
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  // decoration: const BoxDecoration(color: Colors.red),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "가치있는 라디오",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  // decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // 배경은 흰색
                          foregroundColor: Colors.black, // 글자는 검은색
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // TODO: 구글 로그인 기능 구현
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.g_mobiledata), // <- 나중에 여기에 구글 로고 이미지 추가
                            SizedBox(width: 8),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 애플 로그인 버튼
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 배경은 검은색
                          foregroundColor: Colors.white, // 글자는 흰색
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // TODO: 애플 로그인 기능 구현
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.apple), // <- 나중에 여기에 애플 로고 이미지 추가
                            SizedBox(width: 8),
                            Text(
                              'Sign in with Apple',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(height: 50, child: const PulsingBarWidget()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
