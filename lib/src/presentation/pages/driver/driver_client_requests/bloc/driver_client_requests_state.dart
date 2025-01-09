
import 'package:equatable/equatable.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';



class DriverClientRequestsState extends Equatable {

  final Resource? response;
  final Resource? responseCreateDriverTripRequest;
  final Resource? responseDriverPosition;
  final int? idDriver;

  const DriverClientRequestsState({
    this.response,
    this.responseCreateDriverTripRequest,
    this.responseDriverPosition,
    this.idDriver,
  });

  DriverClientRequestsState copyWith({
    Resource? response,
    Resource? responseCreateDriverTripRequest,
    Resource? responseDriverPosition,
    int? idDriver,
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
      responseCreateDriverTripRequest: responseCreateDriverTripRequest,
      responseDriverPosition: responseDriverPosition ?? this.responseDriverPosition,
      idDriver: idDriver ?? this.idDriver,
    );
  }

  @override
  List<Object?> get props => [ response, responseCreateDriverTripRequest,  responseDriverPosition, idDriver ];
}