 
 
  abstract class ClientHomeEvent {}

 class ChangeDrawerPage extends ClientHomeEvent{
  final int pageIdex;
  ChangeDrawerPage({ required this.pageIdex });
 }

 class Logout extends ClientHomeEvent{}

 class GetUserInfoHome extends ClientHomeEvent{}