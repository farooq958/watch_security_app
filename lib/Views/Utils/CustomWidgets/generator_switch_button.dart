import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Controllers/Cubits/ToggleGeneratorCubit/toggle_cubit.dart';
import 'package:watch_dog/Controllers/Cubits/ToggleGeneratorCubit/toggle_generator_cubit.dart';
import 'package:watch_dog/Controllers/Cubits/WatchDogCubit/watch_dog_cubit.dart';
import 'package:watch_dog/Controllers/watch_dog_controller.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/custom_loading_indicator.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';

class GeneratorSwitch extends StatefulWidget {
  final String? generatorStatus;

  const GeneratorSwitch({super.key, required this.generatorStatus});

  @override
  State<GeneratorSwitch> createState() => _GeneratorSwitchState();
}

class _GeneratorSwitchState extends State<GeneratorSwitch> {
  final bool value = true;

  bool toggleGenerator({required String? generatorStatus}) {
    // debugPrint('toggle generator');
    // context.read<ToggleGeneratorCubit>().toggleGenerator();
    if (widget.generatorStatus == '1') {
      return true;
    } else if (widget.generatorStatus == '0') {
      return false;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.sp,
      color: AppColors.white,
      margin: EdgeInsets.only(right: 160.sp),
      child: Stack(
        children: [
          Positioned(
            top: 0.sp,
            left: 0.sp,
            right: 0.sp,
            child: Container(
              height: 120.sp,
              width: 40.sp,
              color: AppColors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: BlocConsumer<ToggleCubit, ToggleState>(
                  listener: (context, toggleState) {
                    if (toggleState is ToggleError) {
                      debugPrint('something went wrong at generator toggling');
                    }
                  },
                  builder: (context, toggleState) {
                    return BlocConsumer<ToggleGeneratorCubit,
                        ToggleGeneratorState>(
                      listener: (context, state) {
                        if (state is ToggleGeneratorError) {
                          debugPrint(
                              'something went wrong at generator toggling UI Updating');
                        }
                      },
                      builder: (context, state) {
                        if (toggleState is ToggleLoading) {
                          return const CustomLoadingIndicator();
                        } else if (toggleState is ToggleSuccess) {
                          return Transform.scale(
                            scale: 5.sp,
                            child: Switch.adaptive(
                              activeColor: AppColors.themeYellow,
                              inactiveThumbColor: AppColors.white,
                              inactiveTrackColor: AppColors.grey,
                              value: toggleGenerator(
                                  generatorStatus: widget.generatorStatus),
                              onChanged: (value) => value,
                            ),
                          );
                        } else {
                          return Transform.scale(
                            scale: 5.sp,
                            child: Switch.adaptive(
                              activeColor: AppColors.themeYellow,
                              inactiveThumbColor: AppColors.white,
                              inactiveTrackColor: AppColors.grey,
                              value: toggleGenerator(
                                  generatorStatus: widget.generatorStatus),
                              onChanged: (value) => value,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.sp,
            left: 0.sp,
            right: 0.sp,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                try {
                  if (WatchDogController.toggle == 1.toString()) {
                    WatchDogController.toggle = 0.toString();
                    await apiCalls();
                  } else if (WatchDogController.toggle == 0.toString()) {
                    WatchDogController.toggle = 1.toString();
                    await apiCalls();
                  }
                } catch (error) {
                  debugPrint('error ==> $error');
                }
              },
              child: Container(
                height: 120.sp,
                width: 40.sp,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> apiCalls() async {
    debugPrint('status ${WatchDogController.toggle}');
    //first api call
    context.read<ToggleCubit>().toggle(
          operation: 'set',
          triggerDevice: 'generator',
          status: WatchDogController.toggle,
          aspDeviceId: WatchDogController.defaultAspDeviceId,
        );

    //second api call
    // context.read<ToggleGeneratorCubit>().toggleGenerator(context: context);

    //third api call
    context
        .read<WatchDogCubit>()
        .fetchWatchDogData(aspDeviceId: WatchDogController.defaultAspDeviceId);
  }
}
