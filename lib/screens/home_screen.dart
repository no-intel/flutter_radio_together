import 'package:flutter/material.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/home/join_widget.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(136, 157, 159, 1),
      body: Stack(
        children: [
          const BackgroundWidget(),
          isLogin
              ? Column(children: [TitleWidget(), JoinWidget()])
              : Column(
                  children: [
                    TitleWidget(),
                    LoginWidget(doLogin: _handleLogin),
                  ],
                ),
        ],
      ),
    );
  }
}
