import 'package:d_map/service/storage.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                autofocus: true,
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  suffixIcon: Icon(Icons.person),
                ),
              ),
            ),
            FutureBuilder(
              future: Future(() {
                return Storage.getString('name');
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != null) {
                    nameController.text = snapshot.data!;
                  }
                  return Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          String name = nameController.text;
                          Storage.saveString('name', name);
                          Navigator.popAndPushNamed(context, '/');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('이름을 입력해주세요.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
