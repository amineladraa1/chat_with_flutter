import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/constants.dart';

// ignore: camel_case_types
class pageView1 extends StatefulWidget {
  const pageView1({
    Key? key,
  }) : super(key: key);

  @override
  State<pageView1> createState() => _pageView1State();
}

// ignore: camel_case_types
class _pageView1State extends State<pageView1>
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
      backgroundColor: const Color(0xffFFAAC3).withAlpha(100),
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
                            'For Android',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: kBlueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'the fastest chatting app for android user we value your securty that\'s why we put mesures for the outmost security for storing your data',
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
                      "images/chat_for_android.json",
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
