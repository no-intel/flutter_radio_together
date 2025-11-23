import 'package:flutter/material.dart';
import 'package:radio_together/widgets/pulsingbar_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(136, 157, 159, 1),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(color: Colors.red),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "가치 있는 라디오",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(color: Colors.blue),
              // 기존 위젯을 새로운 펄스 애니메이션 위젯으로 교체합니다.
              child: PulsingBarWidget(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(color: Colors.green),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset('assets/images/radio-main.png')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
