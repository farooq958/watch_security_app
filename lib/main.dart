import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Controllers/Cubits/ActiveESPListCubit/active_esp_list__cubit.dart';
import 'package:watch_dog/Controllers/Cubits/ToggleGeneratorCubit/toggle_cubit.dart';
import 'package:watch_dog/Controllers/Cubits/ToggleGeneratorCubit/toggle_generator_cubit.dart';
import 'package:watch_dog/Controllers/Cubits/WatchDogCubit/watch_dog_cubit.dart';
import 'package:watch_dog/Views/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<WatchDogCubit>(
              create: (BuildContext context) => WatchDogCubit(),
            ),
            BlocProvider<ActiveEspListCubit>(
              create: (BuildContext context) => ActiveEspListCubit(),
            ),
            BlocProvider<ToggleGeneratorCubit>(
              create: (BuildContext context) => ToggleGeneratorCubit(),
            ),
            BlocProvider<ToggleCubit>(
              create: (BuildContext context) => ToggleCubit(),
            ),
          ],
          child: const MaterialApp(
            useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: MainScreen(),
          ),
        );
      },
    );
  }
}
