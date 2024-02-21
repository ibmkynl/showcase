import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:showcase/scenes/splash/view/splash_scene.dart';
import 'package:showcase/storage/shared_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedManager.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Showcase',
        home: Container(color: Colors.white, child: const SafeArea(child: SplashScene())),
      ),
    );
  }
}
