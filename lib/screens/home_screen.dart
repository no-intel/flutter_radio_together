import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/home/join_widget.dart';
import 'package:radio_together/widgets/home/login_widget.dart';
import 'package:radio_together/widgets/home/pulsingbar_widget.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF9333EA), // purple-600
              Color(0xFF4F46E5), // indigo-600
              Color(0xFF2563EB), // blue-600
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            const BackgroundWidget(),
            FutureBuilder(
              future: ref.read(getPositionServiceProvider).getMyPosition(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Hero(
                      tag: 'pulse',
                      child: SizedBox(
                        height: 50,
                        child: const PulsingBarWidget(),
                      ),
                    ),
                  );
                }
                return isLogin
                    ? Column(
                        children: [
                          const TitleWidget(),
                          JoinWidget(myPosition: myPosition),
                        ],
                      )
                    : Column(
                        children: [
                          const TitleWidget(),
                          LoginWidget(
                            doLogin: _handleLogin,
                            myPosition: myPosition,
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
