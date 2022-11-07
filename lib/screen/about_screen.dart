import 'package:flutter/material.dart';

import '../common/constants.dart';

class AboutScreen extends StatelessWidget {

  static const routeName = '/about';

  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 85, 85, 85),
                  child: Center(
                    child: Image.asset(
                      'assets/movie.png',
                      width: 400,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: whiteColor70,
                  child: const Text(
                    'Aplikasi merupakan sebuah kumplan dari beberapa film yang tayang. Aplikasi ini dibuat sebagai bahan tugas mini project yang diberikan oleh Alterra Academy.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}