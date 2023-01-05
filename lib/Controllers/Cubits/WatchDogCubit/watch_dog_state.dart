part of 'watch_dog_cubit.dart';

@immutable
abstract class WatchDogState {}

class WatchDogInitial extends WatchDogState {}

class WatchDogLoading extends WatchDogState {}

class WatchDogSuccess extends WatchDogState {}

class WatchDogError extends WatchDogState {
  final String? errorMessage;

  WatchDogError(this.errorMessage);
}

class WatchDogNoInternet extends WatchDogState {}
