import 'package:geolocator/geolocator.dart';

import '../../model/my_position.dart';

class GetPositionService {
  Future<MyPosition> getMyPosition() async {
    // 위치 서비스가 활성화되어 있는지 확인합니다.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('주파수는 위치에 따라 다르므로 위치 서비스 활성화가 필수 입니다.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 권한이 거부되면 다음 번에 다시 시도할 수 있도록 합니다.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 권한이 영구적으로 거부되면 앱 설정으로 직접 이동하도록 요청할 수 있습니다.
      return Future.error(
        '주파수는 위치에 따라 다르므로 위치 서비스 활성화가 필수 입니다. 설정에서 위치 권환을 설정해 주세요.',
      );
    }

    Position position = await Geolocator.getCurrentPosition();

    // 가져온 좌표를 콘솔에 출력합니다.
    print(
      '현재 위치: Latitude: ${position.latitude}, Longitude: ${position.longitude}',
    );

    return MyPosition(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
