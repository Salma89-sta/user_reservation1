part of 'items_cubit.dart';

abstract class ItemsState {}

class ItemsInitial extends ItemsState {}
class ItemsLoading extends ItemsState{}
class ItemsLoaded extends ItemsState{}
class ItemsFail extends ItemsState{}
class NoItems extends ItemsState{}
class ItemFreeTimesLoading extends ItemsState{}
class ItemFreeTimesLoaded extends ItemsState{}
class ItemFreeTimesFailed extends ItemsState{}


