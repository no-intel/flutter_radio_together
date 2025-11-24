import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radio_together/screens/home_screen.dart';
import 'package:radio_together/services/home/get_position_service.dart';

final getPositionServiceProvider = Provider<GetPositionService>((ref) {
  return GetPositionService();
});

void main() {
  // 앱의 최상위 위젯을 ProviderScope로 감싸서 Riverpod를 활성화합니다.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      child: MaterialApp(title: "radio_together", home: HomeScreen()),
    );
  }
}
