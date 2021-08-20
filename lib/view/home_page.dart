

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idejualan/helpers.dart';
import 'package:idejualan/model/user_body.dart';
import 'package:idejualan/service/log_login/log_login_bloc.dart';
import 'package:idejualan/service/log_login/log_login_event.dart';
import 'package:idejualan/service/log_login/log_login_state.dart';

class HomePage extends StatefulWidget {
  final UserBody userBody;
  const HomePage({Key? key, required this.userBody}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late LogLoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LogLoginBloc();
    loginBloc.add(LogLoginFetchFromLocal(widget.userBody.email ?? ""));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Home"
        ),
      ),
      body: SafeArea(
        child: Container(
          width: Helpers.getWidth(context),
          height: Helpers.getHeight(context),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Selamat Datang di Idejualan Testing",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 24,),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Email"
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.userBody.email}"
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Gender"
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.userBody.gender}"
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                  "Log Login"
              ),

              SizedBox(height: 16),

              BlocBuilder(
                bloc: loginBloc,
                builder: (context, state) {
                  if (state is LogLoginLoaded) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${state.data[index].email}",
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${state.data[index].createdAt}",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
