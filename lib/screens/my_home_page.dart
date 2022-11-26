import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/constants/constants.dart';
import 'package:my_chat/screens/login.dart';

import '../ui/page_view1.dart';
import '../ui/page_view2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _controller = PageController();
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
            onPageChanged: (value) => setState(() {
                  _pageIndex = value;
                }),
            controller: _controller,
            children: const [
              pageView1(),
              pageView2(),
            ]),
        Align(
          alignment: const Alignment(0.0, 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _pageIndex == 1
                  ? IconButton(
                      onPressed: () => setState(() {
                        _controller.previousPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn);
                      }),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                      iconSize: 25.0,
                      color: kBlueGrey,
                    )
                  : const SizedBox(),
              DotsIndicator(
                dotsCount: 2,
                position: _pageIndex.toDouble(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              _pageIndex == 1
                  ? TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, MyLogin.loginId),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: kBlueGrey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ))
                  : IconButton(
                      onPressed: () => setState(() {
                        _controller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn);
                      }),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      iconSize: 25.0,
                      color: kBlueGrey,
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
