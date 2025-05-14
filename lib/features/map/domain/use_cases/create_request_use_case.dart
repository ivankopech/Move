import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/create_request_repository_interface.dart';
import '../../data/models/create_request.dart';

class CreateRequestUseCase {
  final CreateRequestRepositoryInterface createRequestRepositoryInterface;

  CreateRequestUseCase({required this.createRequestRepositoryInterface});

  Future<Either<ApiException, CreateRequestModel?>> call(
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
    return createRequestRepositoryInterface.createRequest(
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
  }
}
