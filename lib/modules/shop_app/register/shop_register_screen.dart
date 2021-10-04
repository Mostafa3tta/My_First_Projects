import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/shop_app/shop_layout.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/network/local/cache_helper.dart';
import 'package:my_first_proj/Shared/stayles/colors.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/cubit.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/shop_app/register/cubit/cubit.dart';
import 'package:my_first_proj/modules/shop_app/register/cubit/states.dart';

class ShopRegisterScreen extends StatefulWidget {

  @override
  _ShopRegisterScreenState createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isPassword = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(

        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.data!.token);
              print(state.loginModel.message);
              CashHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value){

                token = state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            }
            else {
              print(state.loginModel.message);
              defaultToastMsg(
                Message: state.loginModel.message.toString(),
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4!
                            .copyWith(
                          color: Colors.black,
                          fontFamily: 'GoetheGothicBold',
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Register now to browser our gold offers",
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(
                          fontSize: 15.0,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Name ",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email ",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "phone ",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
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
                      Container(
                          child: state is! ShopRegisterLoadingState ?
                          defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: "Register Now",
                          ) : Center(child: CircularProgressIndicator())
                      ),
                    ],
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
