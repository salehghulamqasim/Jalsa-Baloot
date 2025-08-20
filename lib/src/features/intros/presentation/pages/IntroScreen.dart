// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playbaloot/src/features/home/presentation/pages/HomeScreen.dart';
import 'package:playbaloot/src/features/intros/presentation/widgets/intro_icon_with_text.dart';

import 'package:vibration/vibration.dart';
// import 'path_to_your/apple_style_button.dart'; // if AppleStyleButton is in another file

class Introscreen extends StatelessWidget {
  const Introscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 34, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Play Baloot',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              const SizedBox(height: 54),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: IntroIconWithText(
                      iconPath: 'assets/Icons/qrcode-freepik.svg',
                      label: 'Scan a QR code to join a room',
                    ),
                  ),
                  Expanded(
                    child: IntroIconWithText(
                      iconPath: 'assets/Icons/cards-freepik.svg',
                      label: 'Play against other players',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 44),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(14, 24, 14, 24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Score\npoints\nand win',
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(height: 140),

              Center(
                child: AppleStyleButton(
                  label: "Get Started",
                  onPressed: () async {
                    if (await Vibration.hasVibrator()) {
                      Vibration.vibrate(duration: 50);
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homescreen(),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint('Pressed!');
                    await _tryFirestoreSmokeTest(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Homescreen()),
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Your test function
Future<void> firestoreSmokeTest() async {
  final doc = FirebaseFirestore.instance.collection('smoke').doc('test1');

  // Write
  await doc.set({'ping': 'pong', 'ts': FieldValue.serverTimestamp()});

  // Read once
  final snap = await doc.get();
  debugPrint('Firestore OK? ${snap.exists}  data=${snap.data()}');
}

Future<void> _tryFirestoreSmokeTest(BuildContext context) async {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Testing Firestore…')));

  try {
    await firestoreSmokeTest().timeout(
      const Duration(seconds: 5),
    ); // avoid indefinite wait

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Firestore OK ✅ (smoke/test1 written)')),
    );
  } catch (e, st) {
    debugPrint('Firestore test failed: $e\n$st');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Firestore error: $e')));
    // Optional: return early if you don’t want to navigate on failure
  }
}
