import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title Section
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 50),
                          child: Text(
                            'Deami',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lilitaOne(
                              textStyle: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 90,
                              ),
                            ),
                          ),
                        ),

                        // Welcome Text Section
                        Column(
                          children: [
                            Text(
                              'Welcome to Deami!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 34,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Stay Connected Anytime, Anywhere!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Continue Button Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
