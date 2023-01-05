part of 'toggle_generator_cubit.dart';

@immutable
abstract class ToggleGeneratorState {}

class ToggleGeneratorInitial extends ToggleGeneratorState {}

class ToggleGeneratorLoading extends ToggleGeneratorState {}

class ToggleGeneratorSuccess extends ToggleGeneratorState {}

class ToggleGeneratorError extends ToggleGeneratorState {
  final String? errorMessage;

  ToggleGeneratorError(this.errorMessage);
}

class ToggleGeneratorNoInternet extends ToggleGeneratorState {}
