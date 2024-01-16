part of 'additional_options_cubit.dart';

@immutable
abstract class AdditionalOptionsState {}

class AdditionalOptionsInitial extends AdditionalOptionsState {}
class AdditionalOptionsLoading extends AdditionalOptionsState {}
class AdditionalOptionsLoaded extends AdditionalOptionsState {}
class AdditionalOptionsFailed extends AdditionalOptionsState {}
