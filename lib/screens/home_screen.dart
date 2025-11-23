import 'package:flutter/material.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/home/login_widget.dart';
import 'package:radio_together/widgets/home/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLogin = false;

  void _handleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(136, 157, 159, 1),
      body: Stack(
        children: [
          const BackgroundWidget(),
          isLogin
              ? const Center(
                  child: Text(
                    "로그인 성공!",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                )
              : Column(
                  children: [
                    const TitleWidget(),
                    LoginWidget(doLogin: _handleLogin),
                  ],
                ),
        ],
      ),
    );
  }
}
