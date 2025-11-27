import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_together/services/create/get_radio_item.dart';
import 'package:radio_together/services/home/get_position_service.dart';

final getPositionServiceProvider = Provider<GetPositionService>((ref) {
  return GetPositionService();
});

final getRadioItemsServiceProvider = Provider<GetRadioItemsService>((ref) {
  return GetRadioItemsService();
});
