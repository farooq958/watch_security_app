import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8.sh,
      width: 1.sw,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: AppColors.themeYellow,
      ),
    );
  }
}
