part of 'active_esp_list__cubit.dart';

@immutable
abstract class ActiveEspListState {}

class ActiveEspListInitial extends ActiveEspListState {}

class ActiveEspListLoading extends ActiveEspListState {}

class ActiveEspListSuccess extends ActiveEspListState {}

class ActiveEspListError extends ActiveEspListState {
  final String? errorMessage;

  ActiveEspListError(this.errorMessage);
}

class ActiveEspListNoInternet extends ActiveEspListState {}
