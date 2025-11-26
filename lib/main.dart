import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radio_together/screens/home_screen.dart';

Future<void> main() async {
  // main 함수에서 비동기 작업을 수행하기 위해 필요합니다.
  WidgetsFlutterBinding.ensureInitialized();
  
  // .env 파일을 로드하여 환경 변수를 초기화합니다.
  await dotenv.load(fileName: ".env");

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
