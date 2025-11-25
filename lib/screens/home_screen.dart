import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/main.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/home/join_widget.dart';
import 'package:radio_together/widgets/home/logins/login_button_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLogin = false;

  MyPosition? myPosition;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      final position = await ref
          .read(getPositionServiceProvider)
          .getMyPosition();

      if (mounted) {
        setState(() {
          myPosition = position;
        });
      }
    } catch (e) {
      throw Error();
      print("위치 정보 가져오기 실패: $e");
    }
  }

  void _handleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          isLogin
              ? JoinWidget(myPosition: myPosition!)
              : LoginButtonWidget(
                  onPressed: _handleLogin,
                  myPosition: myPosition,
                ),
        ],
      ),
    );
  }
}
