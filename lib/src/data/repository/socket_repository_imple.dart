import 'package:hey_taxi_app/src/domain/repository/socket_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';


class SocketRepositoryImpl implements SocketRepository {

  Socket socket;

  SocketRepositoryImpl( this.socket );

  @override
  Socket connect() {
    return socket.connect();
  }

  @override
  Socket disconnect() {
    return socket.disconnect();
  }

}