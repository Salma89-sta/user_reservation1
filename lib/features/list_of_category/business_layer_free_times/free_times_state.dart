part of 'free_times_cubit.dart';

@immutable
abstract class FreeTimesState {}

class FreeTimesInitial extends FreeTimesState {}
class ItemFreeTimesLoading extends FreeTimesState{}
class ItemFreeTimesLoaded extends FreeTimesState{}
class ItemFreeTimesLoadedButEmpty extends FreeTimesState{}

class ItemFreeTimesFailed extends FreeTimesState{}