import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/api/api_firebase.dart';
import 'package:my_chat/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_chat/screens/register.dart';

class MyLogin extends StatefulWidget {
  static String loginId = 'MyLogin';
  const MyLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  FireApi api = FireApi();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ? Colors.transparent : Colors.white,
      body: Stack(children: [
        SvgPicture.asset(
          'images/waves.svg',
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.only(left: 35, top: 80),
          child: const Text(
            "Welcome\nBack",
            style: TextStyle(color: Colors.white, fontSize: 33),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: 35,
                left: 35,
                top: MediaQuery.of(context).size.height * 0.5),
            child: Column(children: [
              TextField(
                onChanged: (value) => email = value,
                decoration: kLoginDecoration.copyWith(hintText: 'Email'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: kLoginDecoration.copyWith(hintText: 'Password'),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: kBlueGrey,
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
                        api.signinWithEmailAndPassword(
                            email, password, context);
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRegister.registerId);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: kBlueGrey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: kBlueGrey,
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
