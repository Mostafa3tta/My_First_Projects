import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_first_proj/Layout/social_app/social_layout.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/network/local/cache_helper.dart';
import 'package:my_first_proj/Shared/stayles/colors.dart';
import 'package:my_first_proj/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:my_first_proj/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/social_app/social_register_screen/social_register_screen.dart';

class SocialLoginScreen extends StatefulWidget {
  @override
  _SocialLoginScreenState createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            defaultToastMsg(
              Message: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState)
            {
              CashHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                navigateAndFinish(
                  context,
                  SocialLayout(),
                );
              });
            }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  HexColor("#acb6e5"),
                  HexColor("#86fde8"),
                ])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 20.0, height: 100.0),
                            Text(
                              'Be',
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            const SizedBox(width: 20.0, height: 100.0),
                            DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'Horizon',
                              ),
                              child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    RotateAnimatedText('AWESOME',
                                        alignment: Alignment.center,
                                        textStyle:
                                            TextStyle(color: Colors.red)),
                                    RotateAnimatedText('OPTIMISTIC',
                                        alignment: Alignment.center,
                                        textStyle:
                                            TextStyle(color: Colors.green)),
                                    RotateAnimatedText('DIFFERENT',
                                        alignment: Alignment.center,
                                        textStyle: TextStyle(
                                            color: Colors.yellowAccent)),
                                  ]),
                            ),
                          ],
                        ),
                        Text(
                          "Login",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                    fontFamily: 'GoetheGothicBold',
                                    fontSize: 30,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            child: AnimatedTextKit(
                              pause: Duration(seconds: 5),
                              animatedTexts: [
                                TyperAnimatedText(
                                    'To enjoy shortening the world'),
                              ],
                              repeatForever: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Email ",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                            maxLines: 1,
                          ),
                        ),
                        Center(
                          child: defaultFormField(
                            onTap: (){},
                            controller: emailController,
                            type: TextInputType.text,
                            onChange: () {},
                            isVaildator: true,
                            validate: () {},
                            label: "Email",
                            prefix: Icons.email,
                            hint: "Enter your Email here",
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Password ",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                            maxLines: 1,
                          ),
                        ),
                        Center(
                          child: defaultFormField(
                            onTap: (){},
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onChange: () {},
                            isVaildator: true,
                            validate: () {},
                            label: "Password",
                            isPassword: isPassword,
                            prefix: Icons.lock,
                            suffixPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            suffix: isPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            hint: "Enter your password here",
                          ),
                        ),
                        SizedBox(height: 20),
                        state is! SocialLoginLoadingState
                            ? Center(
                                child: AnimatedButton(
                                  height: 70,
                                  width: 200,
                                  text: "login",
                                  isReverse: true,
                                  selectedTextColor: Colors.black,
                                  transitionType: TransitionType.LEFT_TO_RIGHT,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                  backgroundColor: HexColor("#6fa8dc"),
                                  selectedBackgroundColor:
                                      Colors.lightBlueAccent,
                                  borderRadius: 50,
                                  borderWidth: 5,
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                ),
                              )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don\'t have account ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontFamily: 'BMovieRetroBrushExtreme',
                                    fontSize: 20,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              child: Text(
                                "Register Now",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontFamily: 'BMovieRetroBrushExtreme',
                                      fontSize: 20,
                                      color: defaultColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
