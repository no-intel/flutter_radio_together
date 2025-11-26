import 'package:flutter/foundation.dart'; // debugPrint를 사용하기 위해 추가합니다.
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/services/create/get_radio_item.dart';

void main() {
  // 테스트 함수를 그룹화합니다.
  group('GetRadioItemsService 테스트', () {
    // test() 함수를 사용하여 개별 테스트 케이스를 만듭니다.
    test('특정 좌표로 라디오 아이템 목록을 성공적으로 가져와야 한다', () async {
      // 1. 테스트 환경에서도 .env 파일을 로드합니다.
      await dotenv.load(fileName: ".env");

      // 2. 서비스의 인스턴스(객체)를 생성합니다.
      final radioService = GetRadioItemsService();

      // 3. 테스트용 좌표를 만듭니다.
      final testPosition = MyPosition(latitude: 37.5665, longitude: 126.9780);
      // 4. 인스턴스를 통해 메소드를 호출하고, await로 결과를 기다립니다.
      final radioItems = await radioService.getRadioItems(testPosition);
      
      // 5. 결과를 확인하기 위해 print 대신 debugPrint를 사용합니다.
      debugPrint('가져온 라디오 아이템 개수: ${radioItems.length}');
      if (radioItems.isNotEmpty) {
        debugPrint('첫 번째 아이템: ${radioItems.first.broadNm}');
      }

      // (선택사항) 결과가 비어있지 않은지 검증합니다.
      expect(radioItems, isNotEmpty);
    });
  });
}
