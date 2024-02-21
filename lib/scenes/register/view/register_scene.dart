import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:showcase/scenes/register/view_model/register_vm.dart';
import 'package:showcase/widgets/atoms/custom_button.dart';
import 'package:showcase/widgets/atoms/custom_textfield.dart';

import '../../home/view/home_scene.dart';

class RegisterScene extends ConsumerStatefulWidget {
  const RegisterScene({super.key});

  @override
  ConsumerState<RegisterScene> createState() => _RegisterSceneState();
}

class _RegisterSceneState extends ConsumerState<RegisterScene> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late FocusNode emailFocus, passwordFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    emailFocus.addListener(emailFocusChange);
    passwordFocus.addListener(passwordFocusChange);
  }

  @override
  void dispose() {
    emailFocus.removeListener(emailFocusChange);
    emailFocus.dispose();
    passwordFocus.removeListener(passwordFocusChange);
    passwordFocus.dispose();
    super.dispose();
  }

  void emailFocusChange() {
    if (!emailFocus.hasFocus) {
      ref.read(registerProvider).emailValidate(email: emailController.text);
    }
  }

  void passwordFocusChange() {
    if (!passwordFocus.hasFocus) {
      ref.read(registerProvider).passwordValidate(password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Welcome"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                  Text(ref.watch(registerProvider).emailErrorString, style: const TextStyle(color: Colors.red)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    hintText: "example@mail.com",
                    focusNode: emailFocus,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                      controller: passwordController, hintText: "password", focusNode: passwordFocus, isObscure: true),
                ],
              ),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                  Text(ref.watch(registerProvider).passwordErrorString, style: const TextStyle(color: Colors.red)),
            ),
            SizedBox(height: 20.h),
            Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              bool loading = ref.watch(registerProvider).loginLoading;

              return CustomButton(
                  title: "Login",
                  loading: loading,
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    bool? result = await ref
                        .read(registerProvider)
                        .login(email: emailController.text, password: passwordController.text);

                    if (!context.mounted) return;

                    //this eliminates this bug, when user try to login with blank fields error text show up but also
                    //snackBar show up too
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result ? "Welcome back.." : "Something went wrong while login..")));

                      if (result) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScene()));
                      }
                    }
                  });
            }),
            const Divider(),
            Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              bool loading = ref.watch(registerProvider).registerLoading;
              return CustomButton(
                  title: "Register",
                  loading: loading,
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    bool? result = await ref
                        .read(registerProvider)
                        .register(email: emailController.text, password: passwordController.text);

                    if (!context.mounted) return;

                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(result ? "Register Successful.." : "Something went wrong while registering..")));

                      if (result) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScene()));
                      }
                    }
                  });
            }),
          ],
        ),
      ),
    );
  }
}
