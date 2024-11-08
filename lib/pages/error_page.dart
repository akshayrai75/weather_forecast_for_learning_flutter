import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    Map errorData =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue[100]!, Colors.deepPurple[800]!],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/error.png'),
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'We encountered an error, please try again later.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Add font weight
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                errorData['error'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Add font weight
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),
      ),
    );
  }
}
