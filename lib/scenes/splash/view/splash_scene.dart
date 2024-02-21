import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:showcase/scenes/home/view/home_scene.dart';
import 'package:showcase/scenes/register/view/register_scene.dart';
import 'package:showcase/scenes/register/view_model/register_vm.dart';

class SplashScene extends ConsumerStatefulWidget {
  const SplashScene({super.key});

  @override
  ConsumerState<SplashScene> createState() => _SplashSceneState();
}

class _SplashSceneState extends ConsumerState<SplashScene> {
  @override
  void initState() {
    _navigate();
    super.initState();
  }

  ///if user already sign in and we have the token, we navigate to home page. - auto login
  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (ref.read(registerProvider).token.isEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScene()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScene()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(fontSize: 66),
        ),
      ),
    );
  }
}
