import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/constants.dart';

// ignore: camel_case_types
class pageView2 extends StatefulWidget {
  const pageView2({
    Key? key,
  }) : super(key: key);

  @override
  State<pageView2> createState() => _pageView2State();
}

// ignore: camel_case_types
class _pageView2State extends State<pageView2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrange.withAlpha(100),
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 250.0, right: 25.0, left: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'For Web Users',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: kBlueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'get the same modern android layout with a fast response chat app .\nyou can create a room with all your friends and family with this free and easy to use app',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey.shade400),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      controller: _controller,
                      "images/chat_for_web.json",
                      // height: 400.0,
                      // width: 300.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
