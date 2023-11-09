import 'package:d_map/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          Color.fromRGBO(34, 139, 34, 1),
                          Color.fromRGBO(34, 139, 34, .6),
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'D map',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(34, 139, 34, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: TextField(
                            controller: idController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusColor: Color.fromRGBO(34, 139, 34, 1),
                              border: const UnderlineInputBorder(),
                              hintText: "ID",
                              labelText: "ID",
                              alignLabelWithHint: false,
                              filled: true,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: pwController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusColor: Color.fromRGBO(34, 139, 34, 1),
                              border: const UnderlineInputBorder(),
                              hintText: "Password",
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                              alignLabelWithHint: false,
                              filled: true,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(34, 139, 34, 1),
                          Color.fromRGBO(34, 139, 34, .6),
                        ],
                      ),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          if (idController.text.isEmpty ||
                              pwController.text.isEmpty) {
                            // 로그인 실패 스낵바 추가
                          } else {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString("id", idController.text);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  // Text(
                  //   "Forgot Password?",
                  //   style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
