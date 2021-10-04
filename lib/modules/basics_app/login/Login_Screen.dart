import 'package:flutter/material.dart';
import 'package:my_first_proj/Shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var Email = TextEditingController();

  var password = TextEditingController();

  bool isPassword = true;

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
                  defaultFormField(
                      onTap: (){},
                      onChange: (){},
                    controller: Email,
                    type: TextInputType.emailAddress,
                    label: "Email",
                    hint: "Enter your Email address",
                    prefix: Icons.email,
                    validate: (s){}
                  ),
                  SizedBox(
                height: 30,
              ),
                  defaultFormField(
                    onTap: (){},
                    onChange: (){},
                    isPassword: isPassword,
                    suffixPressed: (){
                      setState(() {
                        isPassword=!isPassword;
                      });
                    },
                    controller: password,
                    type: TextInputType.visiblePassword,
                    label: "Password",
                    hint: "password",
                    prefix: Icons.password_outlined,
                    suffix: isPassword?Icons.visibility:Icons.visibility_off,
                    validate: (s){},
                  ),
                  SizedBox(
                height: 30,
              ),
                  defaultButton(
                    function: (){
                      if(_formKey.currentState!.validate())
                      {
                        print (Email.text);
                        print (password.text);
                      }
                    },
                    text: 'login',
                    isUpperCase: true,
                  ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don 't have an account ?",
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Register Now"),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
