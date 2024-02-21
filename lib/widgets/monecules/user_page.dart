import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:showcase/models/page_model.dart';
import 'package:showcase/scenes/home/view_model/home_vm.dart';
import 'package:showcase/widgets/atoms/user_card.dart';

import '../../models/user_model.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PageModel> pages = ref.watch(homeProvider).pageList;
    int currentPage = ref.watch(homeProvider).currentPage;

    return pages.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: pages[currentPage - 1].users.length,
            itemBuilder: (context, index) {
              User user = pages[currentPage - 1].users[index];
              return UserCard(user: user);
            });
  }
}
