import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playbaloot/src/features/create/presentation/pages/CreateScreen.dart';

import 'package:playbaloot/src/features/intros/presentation/widgets/intro_icon_with_text.dart';
import 'package:playbaloot/src/features/join/presentation/pages/JoinDialog.dart';

import 'package:vibration/vibration.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //to go back to previous page
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Join Or Create Room',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                const SizedBox(height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    //container -- 1
                    Container(
                      width: 140,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // HapticFeedback.heavyImpact(); // or mediumImpact(), heavyImpact(), selectionClick()

                              if (await Vibration.hasVibrator()) {
                                Vibration.vibrate(duration: 40);
                              }

                              //    Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Joinscreen(),
                              //   ),
                              // );
                              joinDialog(context);
                            },
                            child: IntroIconWithText(
                              iconPath: 'assets/Icons/Qr-Code2.svg',
                              label: 'Join Room',
                              iconSize: 72,

                              textSize: 28,
                              iconColor: Color(0xFF0000FF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //container -- 2
                    SizedBox(width: 20), // Add space between the two containers
                    Container(
                      width: 140,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (await Vibration.hasVibrator()) {
                                Vibration.vibrate(duration: 40);
                              }

                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Createscreen(),
                                ),
                              );
                            },
                            child: IntroIconWithText(
                              iconPath: 'assets/Icons/square-plus.svg',
                              label: 'Create Room',
                              iconSize: 72,
                              textSize: 28,
                              iconColor: Color(0xFF0000FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //if u wanna add something then add below this line
              ],
            ),
          ),
        ),
      ),
    );
  }
}
