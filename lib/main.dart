import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idejualan/helpers.dart';
import 'package:idejualan/service/log_login/log_login_bloc.dart';
import 'package:idejualan/service/register/register_bloc.dart';
import 'package:idejualan/service/register/register_event.dart';
import 'package:idejualan/service/register/register_state.dart';
import 'package:idejualan/view/home_page.dart';
import 'package:idejualan/view/register.dart';

import 'model/user_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(),
        ),
        BlocProvider<LogLoginBloc>(
          create: (BuildContext context) => LogLoginBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Login',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late RegisterBloc registerBloc;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    registerBloc = RegisterBloc();
    registerBloc.listen((state) {
      if (state is LoginLoaded) {
        if (state.userBody != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(
              userBody: state.userBody!,
            )),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('email atau password salah'),
                backgroundColor: Colors.red,
              ));
        }
      }

      if (state is LoginNotLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('email atau password salah'),
              backgroundColor: Colors.red,
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: Helpers.getWidth(context),
          height: Helpers.getHeight(context),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Aplikasi",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold
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
              InkWell(
                onTap: () {
                  onLoginClicked();
                },
                child: Container(
                  width: Helpers.getWidth(context),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xff211F1F),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onLoginClicked() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text);

      if (emailValid) {

        registerBloc.add(LoginUserFetchFromLocal(
            userBody: UserBody(
                email: emailController.text,
                password: passwordController.text
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
