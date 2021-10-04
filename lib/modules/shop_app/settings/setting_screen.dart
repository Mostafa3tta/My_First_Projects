import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:my_first_proj/Layout/shop_app/cubit/cubit.dart';
import 'package:my_first_proj/Layout/shop_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/login_screen.dart';

class SettingScreen extends StatelessWidget {

  var formKey= GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              ShopCubit.get(context).userModel != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: defaultFormField(
                        onTap: (){},
                        controller: nameController,
                        type: TextInputType.name,
                        onChange: () {},
                        validate: () {},
                        isVaildator: true,
                        label: "name",
                        prefix: Icons.person,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: defaultFormField(
                        onTap: (){},
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        onChange: () {},
                        validate: () {},
                        isVaildator: true,
                        label: "Email Address",
                        prefix: Icons.email,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: defaultFormField(
                        onTap: (){},
                        controller: phoneController,
                        type: TextInputType.phone,
                        onChange: () {},
                        validate: () {},
                        isVaildator: true,
                        label: "Phone Number",
                        prefix: Icons.phone,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: defaultButton(
                        function: () {
                          if(formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserModel(
                              phone: phoneController.text,
                              name: nameController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: "Update",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: defaultButton(
                        function: () {
                          SignOut(context);
                        },
                        text: "Logout",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallbackBuilder: (context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
