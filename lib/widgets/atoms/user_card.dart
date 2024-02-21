import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.r),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.black12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(user.avatar),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("${user.firstName} ${user.lastName}"), SizedBox(height: 10.h), Text(user.email)],
            ),
          )
        ],
      ),
    );
  }
}
