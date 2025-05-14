import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/map/data/models/request_info.dart';

class ImagesNotifier extends StateNotifier<ImagesModel> {
  ImagesNotifier() : super(ImagesModel(nombre: '', mimeType: '', data: ''));

  void setName(String value) {
    state = state.copyWith(nombre: value);
  }

  void setMimeType(String value) {
    state = state.copyWith(mimeType: value);
  }

  void setData(String value) {
    state = state.copyWith(data: value);
  }
}
