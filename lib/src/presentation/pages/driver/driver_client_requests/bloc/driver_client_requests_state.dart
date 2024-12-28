
import 'package:equatable/equatable.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';



class DriverClientRequestsState extends Equatable {

  final Resource? response;

  const DriverClientRequestsState({
    this.response,
  });

  DriverClientRequestsState copyWith({
    Resource? response,
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [ response ];
}