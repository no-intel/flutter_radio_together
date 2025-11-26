import 'package:flutter/material.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/widgets/create/radio_item_widget.dart';
import 'package:radio_together/widgets/home/background_widget.dart';

class CreateRoomScreen extends StatelessWidget {
  final MyPosition myPosition;

  const CreateRoomScreen({super.key, required this.myPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '방 만들기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: FutureBuilder(
                  future: ,
                  builder: (context, snapshot) => ListView(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    children: const [
                      RadioListItem(
                        title: 'Chill Vibes Radio',
                        subtitle: 'Lo-Fi / Chill',
                        listeners: '1,234 청취자',
                        iconColor: Color(0xFFC084FC),
                        playButtonColor: Color(0xFF7C3AED),
                        isLive: true,
                      ),
                      RadioListItem(
                        title: 'K-Pop Hits',
                        subtitle: 'K-Pop',
                        listeners: '3,456 청취자',
                        iconColor: Color(0xFFF472B6),
                        playButtonColor: Color(0xFF7C3AED),
                        isLive: true,
                      ),
                      RadioListItem(
                        title: 'Jazz Cafe',
                        subtitle: 'Jazz',
                        listeners: '891 청취자',
                        iconColor: Color(0xFFFB923C),
                        playButtonColor: Color(0xFF7C3AED),
                      ),
                      RadioListItem(
                        title: 'Electronic Beats',
                        subtitle: 'EDM',
                        listeners: '2,134 청취자',
                        iconColor: Color(0xFF60A5FA),
                        playButtonColor: Color(0xFF7C3AED),
                        isLive: true,
                      ),
                      RadioListItem(
                        title: 'Midnight Drive',
                        subtitle: 'Synthwave',
                        listeners: '5,678 청취자',
                        iconColor: Color(0xFF818CF8),
                        playButtonColor: Color(0xFF7C3AED),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
