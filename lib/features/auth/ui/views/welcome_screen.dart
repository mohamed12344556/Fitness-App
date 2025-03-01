import 'package:flutter/material.dart';
import 'package:fitness_app/core/routes/routs.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF000F29), Color(0xFF001845)],
              ),
            ),
          ),

          Positioned(
            top: -MediaQuery.of(context).size.height * 0.40,
            left: -MediaQuery.of(context).size.width * 0.5,
            right: -MediaQuery.of(context).size.width * 0.5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(400),
                  bottomRight: Radius.circular(400),
                ),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  // sign up button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E65F3),
                      fixedSize: const Size(250, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // login button
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.logIn);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(250, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001845),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
