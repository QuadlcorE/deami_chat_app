import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ThemeTestPage extends StatelessWidget {
  const ThemeTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('GDsdfssdfs'),
        leading: const Icon(Icons.on_device_training),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_shopping_cart),
        onPressed: () => {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Heading",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "Heading",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Heading",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Elevated button"),
            ),
            OutlinedButton(
              onPressed: () => {},
              child: const Text("Outlined Button"),
            ),
            TextButton(
              onPressed: () => {},
              child: const Text("Text button"),
            ),
          ],
        ),
      ),
    );
  }
}
