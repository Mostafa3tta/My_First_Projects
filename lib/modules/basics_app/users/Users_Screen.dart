import 'package:flutter/material.dart';
import 'package:my_first_proj/models/user/user_model.dart';



class UsersScreen extends StatelessWidget
{
  List<UserModel> users =
  [
    UserModel(
      id: 1,
      name: "Mostafa",
      phone: "01062947371"
    ),
    UserModel(
        id: 2,
        name: "Mohamed",
        phone: "0101231271"
    ),
    UserModel(
        id: 3,
        name: "3tta",
        phone: "0113157322"
    ),
    UserModel(
        id: 4,
        name: "Ahmed",
        phone: "015465615",
    ),
    UserModel(
        id: 5,
        name: "ali",
        phone: "01515615145",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Users",
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context,index)=> buildUserItem(users[index]),
            separatorBuilder: (context,index)=>Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount: users.length,
        ));
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
