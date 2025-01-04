
import 'package:equatable/equatable.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';



class DriverClientRequestsState extends Equatable {

  final Resource? response;
  final Resource? responseCreateDriverTripRequest;

  const DriverClientRequestsState({
    this.response,
    this.responseCreateDriverTripRequest,
  });

  DriverClientRequestsState copyWith({
    Resource? response,
    Resource? responseCreateDriverTripRequest,
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
      responseCreateDriverTripRequest: responseCreateDriverTripRequest ?? this.responseCreateDriverTripRequest,
    );
  }

  @override
  List<Object?> get props => [ response, responseCreateDriverTripRequest ];
}