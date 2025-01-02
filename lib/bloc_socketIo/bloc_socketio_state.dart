import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BlocSocketIoState extends Equatable {

  final Socket? socket;

  const BlocSocketIoState({this.socket});

  BlocSocketIoState copyWith({Socket? socket}) {
    return BlocSocketIoState(socket: socket);
  }

  @override
  List<Object?> get props => [socket];

}