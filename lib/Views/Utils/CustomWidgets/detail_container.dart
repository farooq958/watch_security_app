import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/generator_switch_button.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';
import 'package:watch_dog/Views/Utils/app_strings.dart';
import 'package:watch_dog/Views/Utils/app_text_styles.dart';

class DetailContainer extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? data;
  final String? outageDuration;

  const DetailContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
    required this.outageDuration,
  });

  //this method will calculate the outage duration
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.sp,
      width: 1.sw,
      color: AppColors.white,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 90.sp),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Divider(color: AppColors.grey),
          Container(
            height: 120.sp,
            width: 1.sw,
            color: AppColors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      icon,
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Text(
                    title!,
                    textAlign: TextAlign.left,
                    style: kTitleStyle,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: title == AppStrings.generator
                      ? GeneratorSwitch(generatorStatus: data!)
                      : title == AppStrings.wapda && data == '1'
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.cancel,
                                color: AppColors.red,
                                size: 100.sp,
                              ),
                            )
                          : title == AppStrings.wapda && data == '0'
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: AppColors.green,
                                    size: 100.sp,
                                  ),
                                )
                              : title == AppStrings.outDur
                                  ? Text(
                                      _printDuration(
                                        Duration(
                                          seconds: int.parse(outageDuration!),
                                        ),
                                      ),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 45.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    )
                                  : title == AppStrings.lastReq
                                      ? Text(
                                          '${DateTime.fromMillisecondsSinceEpoch(int.tryParse(data!)! * 1000).hour}:${DateTime.fromMillisecondsSinceEpoch(int.tryParse(data!)! * 1000).minute}:${DateTime.fromMillisecondsSinceEpoch(int.tryParse(data!)! * 1000).second}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 46.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black,
                                          ),
                                        )
                                      : Text(
                                          data!,
                                          textAlign: TextAlign.left,
                                          style: kDataStyle,
                                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
