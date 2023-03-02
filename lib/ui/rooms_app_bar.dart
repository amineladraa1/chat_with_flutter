import 'package:flutter/material.dart';
import 'package:my_chat/constants/constants.dart';
import 'package:my_chat/ui/search_appbar.dart';

class RoomCustomAppBar extends StatefulWidget {
  const RoomCustomAppBar(
      {super.key, required this.offset, required this.topPadding});
  final double? offset;
  final double? topPadding;

  @override
  State<RoomCustomAppBar> createState() => _RoomCustomAppBarState();
}

class _RoomCustomAppBarState extends State<RoomCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Stack(
      children: [
        ClipPath(
            clipper: _AppBarWaveClipper(),
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [kBlueGrey, Color.fromARGB(255, 157, 203, 255)],
                )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Your Rooms',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                        ),
                      ),
                      IconButton(
                          iconSize: 50.0,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.manage_accounts_rounded,
                            color: Colors.white,
                            size: 50.0,
                          ))
                    ],
                  ),
                ],
              ),
            ])),
        Positioned(
          top: widget.topPadding! + widget.offset!,
          left: 16,
          right: 16,
          // ignore: prefer_const_constructors
          child: SearchBar(),
        )
      ],
    );
  }
}

class _AppBarWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    const minSize = 140.0;
    final p1Diff = ((minSize - size.height) * 0.5).truncate().abs();
    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, minSize);

    path.lineTo(0.0, size.height - p1Diff);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this ? true : false;
  }
}
