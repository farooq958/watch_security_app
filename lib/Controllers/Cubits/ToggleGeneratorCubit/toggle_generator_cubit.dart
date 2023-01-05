import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:watch_dog/Controllers/Repositories/toggle_generator_repo.dart';
import 'package:watch_dog/Controllers/watch_dog_controller.dart';

part 'toggle_generator_state.dart';

class ToggleGeneratorCubit extends Cubit<ToggleGeneratorState> {
  ToggleGeneratorCubit() : super(ToggleGeneratorInitial());

  ///Toggle generator api method
  toggleGenerator({required BuildContext context}) async {
    try {
      emit(ToggleGeneratorLoading());
      final response = await ToggleGeneratorRepo.toggleGenerator(
          cmd: WatchDogController.toggle);
      debugPrint(
          'Toggle Generator returned status code at cubit ==> $response');

      if (response == 200 || response == null) {
        emit(ToggleGeneratorSuccess());
      } else if (response == 10) {
        emit(ToggleGeneratorNoInternet());
      } else {
        emit(
          ToggleGeneratorError('An error occurred while toggling generator'),
        );
      }
    } on Exception catch (e) {
      debugPrint('Toggle generator cubit error $e');
    }
  }
}
