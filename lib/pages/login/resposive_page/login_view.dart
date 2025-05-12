import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routers_name.dart';

class LoginView extends StatelessWidget {
  final double width;
  const LoginView({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passWordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
            width: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HRM',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Username'),
                        // hintText: S.current.username,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    // initialValue: username,
                    // onChanged: (value) {
                    //   context
                    //       .read<LoginBloc>()
                    //       .add(LoginEvent.changeUsername(value));
                    // },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label:
                            Text('Password'), // hintText: S.current.password,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    obscureText: true,
                    // initialValue: password,
                    // onChanged: (value) {
                    //   context
                    //       .read<LoginBloc>()
                    //       .add(LoginEvent.changePassword(value));
                    // },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 47, 141, 212),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(307, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9))),
                      onPressed: () {
                        context.go(RouterName.dashboard);
                        // context.read<LoginBloc>().add(const LoginEvent.login());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Forgot Password? Get support',
                    style: TextStyle(
                        color: Color.fromARGB(255, 47, 141, 212), fontSize: 15),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
