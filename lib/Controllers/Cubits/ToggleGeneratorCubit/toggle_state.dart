part of 'toggle_cubit.dart';

@immutable
abstract class ToggleState {}

class ToggleInitial extends ToggleState {}

class ToggleLoading extends ToggleState {}

class ToggleSuccess extends ToggleState {}

class ToggleError extends ToggleState {
  final String? errorMessage;

  ToggleError(this.errorMessage);
}

class ToggleNoInternet extends ToggleState {}
