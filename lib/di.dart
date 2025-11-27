import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/services/home/get_position_service.dart';

final getPositionServiceProvider = Provider<GetPositionService>((ref) {
  return GetPositionService();
});
