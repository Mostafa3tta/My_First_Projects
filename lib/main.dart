import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/shop_app/shop_layout.dart';
import 'package:my_first_proj/Layout/social_app/cubit/cubit.dart';
import 'package:my_first_proj/Layout/social_app/social_layout.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/login_screen.dart';
import 'Layout/news_app/cubit/cubit.dart';
import 'Layout/shop_app/cubit/cubit.dart';
import 'Shared/bloc_observer.dart';
import 'dart:async';
import 'Shared/components/constanse.dart';
import 'Shared/cubit/cubit.dart';
import 'Shared/cubit/states.dart';
import 'Shared/network/local/cache_helper.dart';
import 'Shared/stayles/themes.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // بيتأكد ان كل حاجه في الميثود خلصت وبعدين يفتح الابلكيشن

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();


  bool? isDark = CashHelper.getBoolData(key: 'isDark');
  Widget? widget;
  bool? onBoarding = CashHelper.getBoolData(key: 'onBoarding');

  token = CashHelper.getData(key: 'token');
  uId = CashHelper.getData(key: 'uId');
  print(token);


  if (onBoarding != null) {
    if (token == null)
      widget = ShopLogin();
    else
      widget = ShopLayout();
  } else
    widget = OnBoardingScreen();

  // if (uId != null){
  //   widget = SocialLayout();
  // }else
  //   {
  //     widget = SocialLoginScreen();
  //   }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

//Class myApp
class MyApp extends StatelessWidget {
  bool? isDark;
  Widget? startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => NewsCubit()
                ..getBusinees()
                ..getSports()
                ..getScience()),
          BlocProvider(
            create: (context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              ),
          ),
          BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserModel(),
          ),
          BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: DarkOrLight(context),
             // themeMode: ThemeMode.light,
              home: OnBoardingScreen(),
            );
          },
        ));
  }
}
