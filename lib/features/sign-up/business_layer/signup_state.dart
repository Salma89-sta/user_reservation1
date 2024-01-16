part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}
class SignypInitial extends SignupState{}
class SignupLoading extends SignupState{}
class SignupSuccess extends SignupState{}
class SignupDublicate extends SignupState{}
class SignupError extends SignupState{
  final String errorMessage;
  SignupError(this.errorMessage);
}