import '../../../../config/api_client.dart';
import '../../data/models/create_request.dart';

abstract class CreateRequestRepositoryInterface {
  Future<Result<CreateRequestModel?>> createRequest(
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
  );
}
