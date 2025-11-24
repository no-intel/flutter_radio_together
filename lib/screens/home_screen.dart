import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/home/join_widget.dart';
import 'package:radio_together/widgets/home/login_widget.dart';
import 'package:radio_together/widgets/home/title_widget.dart';

import '../main.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLogin = false;
  late MyPosition myPosition;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    setState(() async {
      myPosition = await ref.read(getPositionServiceProvider).getMyPosition();
    });
  }

  void _handleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build@@@@');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(136, 157, 159, 1),
      body: Stack(
        children: [
          const BackgroundWidget(),
          isLogin
              ? const Column(children: [TitleWidget(), JoinWidget()])
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
