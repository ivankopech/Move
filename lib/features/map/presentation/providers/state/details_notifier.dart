import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/map/data/models/request_info.dart';

class DetailsNotifier extends StateNotifier<DetailsModel> {
  DetailsNotifier()
    : super(DetailsModel(description: '', startDate: '', startTime: ''));

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setStartDate(String value) {
    state = state.copyWith(startDate: value);
  }

  void setStartTime(String value) {
    state = state.copyWith(startTime: value);
  }
}
