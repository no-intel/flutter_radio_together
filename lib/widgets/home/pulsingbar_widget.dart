import 'dart:math';

import 'package:flutter/material.dart';

class PulsingBarWidget extends StatefulWidget {
  const PulsingBarWidget({super.key});

  @override
  State<PulsingBarWidget> createState() => _PulsingBarWidgetState();
}

class _PulsingBarWidgetState extends State<PulsingBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러를 생성하고, 1.2초 주기로 반복 실행합니다.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // AnimatedBuilder를 사용하여 애니메이션의 매 프레임마다 UI를 다시 그립니다.
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (i) {
              // sin 함수를 이용해 부드러운 웨이브 움직임을 만듭니다.
              final double heightFactor =
                  (0.5 * sin(2 * pi * _controller.value - (i + 1) * pi / 4) +
                  0.5);
              return Container(
                width: 12,
                // 높이를 최소 10에서 최대 60까지 애니메이션합니다.
                height: 10 + (50 * heightFactor),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
