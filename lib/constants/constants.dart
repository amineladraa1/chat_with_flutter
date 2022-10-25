import 'package:flutter/material.dart';

InputDecoration kRegisterInput = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kOrange),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.white),
  ),
  hintStyle: const TextStyle(color: Colors.white),
);

InputDecoration kLoginDecoration = InputDecoration(
  fillColor: kBlueGrey.withAlpha(30),
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kOrange),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kBlueGrey),
  ),
  hintStyle: const TextStyle(color: kBlueGrey),
);

const Color kOrange = Color(0xffFBB348);
const Color kBlueGrey = Color(0xff88A1E2);
