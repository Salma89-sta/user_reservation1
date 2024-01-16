part of 'user_update_data_cubit.dart';

@immutable
abstract class UserUpdateDataState {}

class UserUpdateDataInitial extends UserUpdateDataState {}
class UserUpdateDataSuccess extends UserUpdateDataState {}
class UserUpdateDataFailed extends UserUpdateDataState {}

