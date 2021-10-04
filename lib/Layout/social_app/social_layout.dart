import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/social_app/cubit/cubit.dart';
import 'package:my_first_proj/Layout/social_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/stayles/icon_brocken.dart';
import 'package:my_first_proj/modules/social_app/new_post/new_post_screen.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if ( state is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  IconBroken.Home,
                ),
              ),
              BottomNavigationBarItem(
                label: "Chat",
                icon: Icon(
                  IconBroken.Chat,
                ),
              ),
              BottomNavigationBarItem(
                label: "Post",
                icon: Icon(
                  IconBroken.Upload,
                ),
              ),
              BottomNavigationBarItem(
                label: "Users",
                icon: Icon(
                  IconBroken.Location,
                ),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(
                  IconBroken.Setting,
                ),
              ),
            ],
          ),

          // Conditional.single(
          //   context: (context),
          //   conditionBuilder: (context) =>
          //       SocialCubit.get(context).model != null,
          //   widgetBuilder: (context) {
          //     var model = SocialCubit.get(context).model;
          //     return Column(
          //       children: [
          //         if (FirebaseAuth.instance.currentUser!.emailVerified==false)
          //           Container(
          //             color: Colors.amber.withOpacity(0.5),
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //               child: Row(
          //                 children: [
          //                   Icon(
          //                     Icons.info_outline,
          //                   ),
          //                   SizedBox(
          //                     width: 8,
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       "Please Verify you email",
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodyText1!
          //                           .copyWith(
          //                             fontSize: 20,
          //                             fontFamily: "GoetheGothicBold",
          //                           ),
          //                     ),
          //                   ),
          //                   SizedBox(width: 20),
          //                   TextButton(
          //                     onPressed: () {
          //                       FirebaseAuth.instance.currentUser!
          //                           .sendEmailVerification()
          //                           .then((value) {
          //                         defaultToastMsg(
          //                           Message: "Check Your Mail",
          //                           state: ToastStates.SUCCESS,
          //                         );
          //                       }).catchError((onError) {});
          //                     },
          //                     child: Text("Send email",
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                         )),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //       ],
          //     );
          //   },
          //   fallbackBuilder: (context) =>
          //       Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }
}
