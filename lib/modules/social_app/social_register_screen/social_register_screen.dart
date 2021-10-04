import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_first_proj/Layout/social_app/social_layout.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/modules/social_app/social_register_screen/cubit/cubit.dart';
import 'package:my_first_proj/modules/social_app/social_register_screen/cubit/states.dart';
import 'package:flutter_conditional_rendering/conditional.dart';


class SocialRegisterScreen extends StatefulWidget {

  @override
  _SocialRegisterScreenState createState() => _SocialRegisterScreenState();
}

class _SocialRegisterScreenState extends State<SocialRegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isPassword = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(

        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder:(context,state){
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
              body:Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          "Register",
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
                                TyperAnimatedText('Join us to connect with your world'),
                              ],
                              repeatForever: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: defaultFormField(
                            onTap: (){},
                            controller: nameController,
                            type: TextInputType.name,
                            onChange: () {},
                            isVaildator: true,
                            validate: () {},
                            label: "Name",
                            prefix: Icons.person,
                            hint: "Enter your Name here",
                          ),
                        ),
                        SizedBox(height: 20),
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
                        Center(
                          child: defaultFormField(
                            onTap: (){},
                            controller: phoneController,
                            type: TextInputType.phone,
                            onChange: () {},
                            isVaildator: true,
                            validate: () {},
                            label: "phone",
                            prefix: Icons.phone,
                            hint: "Enter your phone here",
                          ),
                        ),
                        SizedBox(height: 20),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is! SocialRegisterLoadingState? ,
                            widgetBuilder: (context) => Center(
                              // child: AnimatedButton(
                              //   height: 70,
                              //   width: 200,
                              //   text: "Register Now",
                              //   isReverse: true,
                              //   selectedTextColor: Colors.black,
                              //   transitionType: TransitionType.LEFT_TO_RIGHT,
                              //   textStyle: TextStyle(
                              //     fontSize: 20,
                              //   ),
                              //   backgroundColor: HexColor("#6fa8dc"),
                              //   selectedBackgroundColor:
                              //   Colors.lightBlueAccent,
                              //   borderRadius: 50,
                              //   borderWidth: 5,
                              //   onPress: () {
                              //     if (formKey.currentState!.validate()) {
                              //       SocialRegisterCubit.get(context).userRegister(
                              //         name: nameController.text,
                              //         email: emailController.text,
                              //         password: passwordController.text,
                              //         phone: phoneController.text,
                              //       );
                              //     }
                              //   },
                              // ),
                            child: defaultButton(function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                              text: 'Register',
                              isUpperCase: true,
                            ),
                            ),
                           fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
                        ) ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
    } ,
    )
    );
  }
}
