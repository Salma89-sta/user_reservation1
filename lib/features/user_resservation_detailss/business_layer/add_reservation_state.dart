part of 'add_reservation_cubit.dart';

@immutable
abstract class AddReservationState {}

class AddReservationInitial extends AddReservationState {}
class AddReservationSuccessfully extends AddReservationState{}
class AddReservationAlreadyReserved extends AddReservationState{}
class AddReservationFailed extends AddReservationState{}
class UpdateReservationSuccessfully extends AddReservationState{}
class UpdateReservationFailed extends AddReservationState{}

