part of 'user_reservations_cubit.dart';

@immutable
abstract class UserReservationsState {}

class UserReservationsInitial extends UserReservationsState {}
class UserReservationsLoading extends UserReservationsState {}
class UserReservationsLoaded extends UserReservationsState {}
class UserReservationsFailed extends UserReservationsState {}
class UserReservationsEmpty extends UserReservationsState {}
class UserDeleteReservationSuccess extends UserReservationsState{}
class UserDeleteReservationFail extends UserReservationsState{}


