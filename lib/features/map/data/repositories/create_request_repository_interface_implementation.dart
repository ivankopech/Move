import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/create_request.dart';
import '../../domain/repositories/create_request_repository_interface.dart';

class CreateRequestRepositoryInterfaceImplementation
    extends CreateRequestRepositoryInterface {
  final ApiClient apiClient;

  CreateRequestRepositoryInterfaceImplementation(this.apiClient);

  @override
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
  ) async {
    try {
      final body = {
        'typeService': typeService,
        "aliasFrom": aliasFrom,
        'streetFrom': streetFrom,
        'cpFrom': cpFrom,
        'cityFrom': cityFrom,
        'numberFrom': numberFrom,
        'countryFrom': countryFrom,
        'florNummberFrom': florNummberFrom,
        'stateFrom': stateFrom,
        'descriptionFrom': descriptionFrom,
        'placeIdFrom': placeIdFrom,
        'latFrom': latFrom,
        'longFrom': longFrom,
        'longDirectionFrom': longDirectionFrom,
        'description': description,
        'startDate': startDate,
        'startTime': startTime,
        'details': details,
        'idVehicle': idVehicle,
        'cantPersons': cantPersons,
        'tramos': tramos,
        'payment': payment,
        'distance': distance,
        'tipPercent': tipPercent,
        'existingFrom': existingFrom,
        'existingTo': existingTo,
      };

      final response = await apiClient.postData(
        'services/app/Solicitud/CreateSolicitudFromClientNew',
        body,
        (json) => CreateRequestModel.fromJson(json),
      );

      return response.fold((error) => Left(error), (data) async {
        return Right(data);
      });
    } catch (e, stackTrace) {
      return Left(
        ApiException(
          code: '500',
          message: 'Error inesperado: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
