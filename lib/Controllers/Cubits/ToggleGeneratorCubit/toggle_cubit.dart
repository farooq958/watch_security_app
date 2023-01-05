import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:watch_dog/Controllers/Repositories/toggle_repo.dart';

part 'toggle_state.dart';

class ToggleCubit extends Cubit<ToggleState> {
  ToggleCubit() : super(ToggleInitial());

  ///Toggle generator api method
  toggle({
    required String? operation,
    required String? triggerDevice,
    required String? status,
    required String? aspDeviceId,
  }) async {
    try {
      emit(ToggleLoading());
      final response = await ToggleRepo.toggle(
        aspDeviceId: aspDeviceId,
        status: status,
        triggerDevice: triggerDevice,
        operation: operation,
      );
      debugPrint('Toggle returned status code at cubit ==> $response');

      if (response == 200 || response == null) {
        emit(ToggleSuccess());
      } else if (response == 10) {
        emit(ToggleNoInternet());
      } else {
        emit(
          ToggleError('An error occurred while toggling'),
        );
      }
    } on Exception catch (e) {
      debugPrint('Toggle cubit error $e');
    }
  }
}
