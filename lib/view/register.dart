import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:idejualan/helpers.dart';
import 'package:idejualan/model/user_body.dart';
import 'package:idejualan/service/register/register_bloc.dart';
import 'package:idejualan/service/register/register_event.dart';
import 'package:idejualan/service/register/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> _items = [
    "Male",
    "Female"
  ];
  String _verticalGroupValue = "";

  late RegisterBloc registerBloc;

  @override
  void initState() {
    initBloc();
    _verticalGroupValue = _items[0];
    super.initState();
  }

  void initBloc() {
    registerBloc = RegisterBloc();
    registerBloc.listen((state) {
      if (state is RegisterLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Silahkan untuk login'),
              backgroundColor: Colors.green,
            ));
        Navigator.pop(context);
      }

      if (state is RegisterNotLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Terjadi kesalahan'),
              backgroundColor: Colors.red,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Helpers.getWidth(context),
          height: Helpers.getHeight(context),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Register Aplikasi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email'
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password'
                ),
              ),
              SizedBox(height: 16,),
              Text(
                "Gender",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16
                ),
              ),
              SizedBox(height: 8,),
              RadioGroup<String>.builder(
                groupValue: _verticalGroupValue,
                onChanged: (value) => setState(() {
                  _verticalGroupValue = value!;
                }),
                items: _items,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              SizedBox(height: 16,),
              InkWell(
                onTap: () {
                  onRegisterClicked();
                },
                child: Container(
                  width: Helpers.getWidth(context),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Color(0xff211F1F),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRegisterClicked() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text);

      if (emailValid) {

        registerBloc.add(RegisterFetchFromLocal(
          userBody: UserBody(
            email: emailController.text,
            password: passwordController.text,
            gender: _verticalGroupValue
          )
        ));

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('email tidak valid'),
              backgroundColor: Colors.red,
            ));
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('email atau password tidak boleh kosong'),
            backgroundColor: Colors.red,
      ));
    }
  }
}
