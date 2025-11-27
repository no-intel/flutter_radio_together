import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/di.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/model/radio_item_model.dart';
import 'package:radio_together/widgets/create/radio_item_widget.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/stream/steam_screen.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  final MyPosition myPosition;

  const CreateRoomScreen({super.key, required this.myPosition});

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  late Future<List<RadioItemModel>> radioItems;

  @override
  void initState() {
    super.initState();
    radioItems = ref
        .read(getRadioItemsServiceProvider)
        .getRadioItems(widget.myPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // 뒤로가기 버튼 색상을 흰색으로 변경
        ),
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
              // 2. 불필요한 흰색 배경 Container 제거
              child: FutureBuilder<List<RadioItemModel>>(
                future: radioItems,
                builder: (context, snapshot) {
                  // 3. 로딩 상태 처리
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  // 4. 에러 상태 처리
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  // 5. 데이터가 없거나 비어있는 경우 처리
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        '주변 라디오 채널이 없습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  // 6. 성공적으로 데이터를 가져왔을 때 ListView.builder를 올바르게 사용
                  final items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length, // 리스트의 전체 개수 지정
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    StreamScreen(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation = animation.drive(
                                    tween,
                                  );
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                          ),
                        ),
                        child: RadioListItem(
                          title: item.serviceNm,
                          subtitle: item.broadNm,
                          listeners: item.brodFreq,
                          iconColor:
                              Colors.primaries[index % Colors.primaries.length],
                          // 아이템마다 다른 색상 적용
                          playButtonColor: const Color(0xFF7C3AED),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
