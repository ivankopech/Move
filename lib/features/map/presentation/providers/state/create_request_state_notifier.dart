import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/create_request.dart';
import '../../../domain/use_cases/create_request_use_case.dart';

class CreateRequestStateNotifier
    extends StateNotifier<AsyncValue<CreateRequestModel?>> {
  final CreateRequestUseCase createRequestUseCase;

  CreateRequestStateNotifier({required this.createRequestUseCase})
    : super(const AsyncValue.data(null));

  late CreateRequestModel? createRequestModel;

  Future<void> createRequest(
    int? typeService,
    String? aliasFrom,
    String? streetFrom,
    String? cpFrom,
    String? cityFrom,
    String? numberFrom,
    String? countryFrom,
    String? florNummberFrom,
    String? stateFrom,
    String? descriptionFrom,
    String? placeIdFrom,
    String? latFrom,
    String? longFrom,
    String? longDirectionFrom,
    String? description,
    String? startDate,
    String? startTime,
    String? details,
    int? idVehicle,
    int? cantPersons,
    List<Tramos>? tramos,
    Payment? payment,
    int? distance,
    int? tipPercent,
    int? existingFrom,
    int? existingTo,
  ) async {
    try {
      state = AsyncValue.loading();
      final result = await createRequestUseCase(
        typeService,
        aliasFrom,
        streetFrom,
        cpFrom,
        cityFrom,
        numberFrom,
        countryFrom,
        florNummberFrom,
        stateFrom,
        descriptionFrom,
        placeIdFrom,
        latFrom,
        longFrom,
        longDirectionFrom,
        description,
        startDate,
        startTime,
        details,
        idVehicle,
        cantPersons,
        tramos,
        payment,
        distance,
        tipPercent,
        existingFrom,
        existingTo,
      );

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          createRequestModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
