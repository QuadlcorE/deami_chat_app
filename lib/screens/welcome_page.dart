import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 50),
                  child: Text(
                    'Deami',
                    style: GoogleFonts.lilitaOne(
                      textStyle: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 90),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Welcome to Deami!',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.normal,
                            fontSize: 34),
                      ),
                    ),
                    Text(
                      'Stay Connected Any time, Any where!',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 20)),
                    ),
                  ],
                ),
                const Spacer(flex: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: ElevatedButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/registration_page')},
                    child: const Text(
                      'Continue',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
