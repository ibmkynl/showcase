import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:showcase/scenes/home/view_model/home_vm.dart';
import 'package:showcase/widgets/monecules/user_page.dart';

class HomeScene extends ConsumerWidget {
  const HomeScene({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users"), centerTitle: true),
      body: Column(
        children: [
          const Expanded(child: UserPage()),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      await ref.read(homeProvider).previousPage();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                Text("${ref.watch(homeProvider).currentPage} / ${ref.watch(homeProvider).totalPages}"),
                IconButton(
                    onPressed: () async {
                      await ref.read(homeProvider).nextPage();
                    },
                    icon: const Icon(Icons.arrow_forward_ios))
              ],
            ),
          )
        ],
      ),
    );
  }
}
