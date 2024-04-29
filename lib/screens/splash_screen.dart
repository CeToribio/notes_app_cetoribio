import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF63539F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('lib/assets/svg/edit.svg',
                width: 100,
                height: 100,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.6), BlendMode.srcIn)),
            const SizedBox(height: 20.0),
            const Text(
              'Bienvenido a NOTES APP',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.symmetric(
                    horizontal: 100.0, vertical: 15.0),
              ),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
