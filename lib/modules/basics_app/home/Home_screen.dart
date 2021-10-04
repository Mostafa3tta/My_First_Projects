import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  var AppBarAction = [
    IconButton(
      icon: Icon(Icons.notification_add),
      onPressed: onNotifcation,
    ),
    IconButton(
      onPressed:() {},
      icon: Icon(
          Icons.search
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          "First App",
        ),
        actions: AppBarAction,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/2560px-Google_2015_logo.svg.png'
                ),
                height: 400,
                width: 400,

              ),
              Text(
                  "جوجل الغلابه"
              ),
            ],
          ),
        ],
      ),
    );
  }
}
void onNotifcation ()
{
  print("No Notification");
}