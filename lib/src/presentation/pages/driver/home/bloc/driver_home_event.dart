 
 
  abstract class DriverHomeEvent {}

 class ChangeDrawerDriverPage extends DriverHomeEvent{
  final int pageIdex;
  ChangeDrawerDriverPage({ required this.pageIdex });
 }

 class Logout extends DriverHomeEvent{}

 class GetUserInfoDriverHome extends DriverHomeEvent{}