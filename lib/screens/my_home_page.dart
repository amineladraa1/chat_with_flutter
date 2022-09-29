import 'package:flutter/material.dart';
import 'package:my_chat/screens/login.dart';
import 'package:my_chat/screens/register.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> textAnimation;
  late Animation<Offset> gifAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    textAnimation =
        Tween<Offset>(begin: const Offset(0, 16.0), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _controller,
                curve: const Interval(
                  0,
                  0.5,
                  curve: Curves.elasticInOut,
                )));
    gifAnimation =
        Tween<Offset>(begin: const Offset(16.0, 0.0), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _controller,
                curve: const Interval(
                  0.5,
                  1,
                  curve: Curves.elasticInOut,
                )));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SlideTransition(
                  position: textAnimation,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 120.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Ladraa Chat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              SlideTransition(
                position: gifAnimation,
                child: Image.asset(
                  "images/conference.gif",
                  height: 300.0,
                  width: 300.0,
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRegister.registerId);
                },
                fillColor: const Color(0xff4c505b),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyLogin.loginId);
                },
                fillColor: const Color(0xff68CAF0),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
