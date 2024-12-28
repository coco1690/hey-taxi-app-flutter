 
 
  abstract class DriverHomeEvent {}

 class ChangeDrawerDriverPage extends DriverHomeEvent{
  final int pageIdex;
  ChangeDrawerDriverPage({ required this.pageIdex });
 }

 class DeleteLocationData extends DriverHomeEvent {
  final int idDriver;
  DeleteLocationData({required this.idDriver});
}

 class Logout extends DriverHomeEvent{}

 class GetUserInfoDriverHome extends DriverHomeEvent{}