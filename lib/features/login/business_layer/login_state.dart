
part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}
class LoginInitial extends LoginState{}
class LoginLoading extends LoginState{}
class LoginSuccess extends LoginState{
}
class LoginError extends LoginState{
  final String errorMessage;
  const LoginError(this.errorMessage);
}

class LoginNotAcceptedYet extends LoginState{}
