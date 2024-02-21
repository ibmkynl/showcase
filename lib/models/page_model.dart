import 'package:showcase/models/support_model.dart';
import 'package:showcase/models/user_model.dart';

class PageModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<User> users;
  final Support support;

  PageModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
    required this.support,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<User> userList = list.map((data) => User.fromJson(data)).toList();

    return PageModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: userList,
      support: Support.fromJson(json['support']),
    );
  }
}
