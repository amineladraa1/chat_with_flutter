import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/api/api_firebase.dart';
// ignore: depend_on_referenced_packages
import 'package:my_chat/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyRegister extends StatefulWidget {
  static String registerId = 'MyRegister';
  const MyRegister({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  FireApi api = FireApi();
  late String email;
  late String password;
  late String name;
  late String lastname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ? Colors.transparent : Colors.white,
      body: Stack(children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
            minHeight: double.infinity,
          ),
          child: SvgPicture.asset(
            'images/wave.svg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 35, top: 120),
          child: const Text(
            "Create\nAccount",
            style: TextStyle(color: Colors.white, fontSize: 33),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: 35,
                left: 35,
                top: MediaQuery.of(context).size.height * 0.27),
            child: Column(children: [
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) => name = value,
                decoration: kRegisterInput.copyWith(hintText: 'name'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) => lastname = value,
                decoration: kRegisterInput.copyWith(hintText: 'last name'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) => email = value,
                decoration: kRegisterInput.copyWith(hintText: 'email'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: kRegisterInput.copyWith(hintText: 'password'),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: kBlueGrey,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      api.signupWithEmailAndPassword(
                          email, password, name, lastname, context);
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ]),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }
}
