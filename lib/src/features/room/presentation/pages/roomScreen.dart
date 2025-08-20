// ignore_for_file: dead_code

import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:playbaloot/src/core/cubit/mr_cubit.dart';
import 'package:playbaloot/src/core/cubit/mr_states.dart';
import 'package:playbaloot/src/features/room/presentation/widgets/roundScoreDialog.dart';
import 'package:playbaloot/src/features/room/presentation/widgets/winScoreDialog.dart';

// ⬇️ Import with a prefix so we refer to the button explicitly.
import 'package:playbaloot/src/features/intros/presentation/widgets/intro_icon_with_text.dart'
    as intro;

class Roomscreen extends StatelessWidget {
  const Roomscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a fresh room code when entering the screen.
    context.read<MrCubit>().generateRoomCode();

    return BlocBuilder<MrCubit, MrState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: const Color(0xFFF7F7F7),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'The Game Room',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // QR container
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 215,
                        height: 258,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Subtle tilt; no glare; no parallax.
                            Motion.elevated(
                              elevation: 16,
                              glare: false,

                              shadow: false,
                              filterQuality: FilterQuality.medium,
                              child: QrImageView(
                                data: state.roomCode,
                                version: QrVersions.auto,
                                size: 200,
                                gapless: true,
                              ),
                            ),
                            const Divider(),
                            Text(
                              state.roomCode,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Monospace",
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        "01:12",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Scores and target
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Team 1",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  state.team1Score.toString(),
                                  style: const TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.06),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Target",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.targetScore.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF007AFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Team 2",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  state.team2Score.toString(),
                                  style: const TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.team1Players.isNotEmpty
                                      ? state.team1Players[0]
                                      : "Player 1",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 16,
                                ), // Space above divider
                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ), // Space below divider
                                Text(
                                  state.team1Players.length > 1
                                      ? state.team1Players[1]
                                      : "Player 2",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  state.team2Players.isNotEmpty
                                      ? state.team2Players[0]
                                      : "Player 1",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 16,
                                ), // Space above divider
                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ), // Space below divider
                                Text(
                                  state.team2Players.length > 1
                                      ? state.team2Players[1]
                                      : "Player 2",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // End round / Finish game button (use namespaced button)
                      intro.AppleStyleButton(
                        label:
                            state.roundEnded ? "Finish the Game" : "End Round",
                        onPressed: () {
                          if (!state.roundEnded) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: true,
                              useSafeArea: true,
                              builder:
                                  (context) => RoundScoreBottomSheet(
                                    title: "Round 3 completed",
                                    teamALabel: 'Team 1',
                                    teamBLabel: "Team 2",
                                    onSubmit: (teamAScore, teamBScore) {
                                      context.read<MrCubit>().addRoundScore(
                                        teamAScore,
                                        teamBScore,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    onCancel: () => Navigator.of(context).pop(),
                                    submitButtonText: 'Continue',
                                  ),
                            );
                          } else {
                            final confettiController = ConfettiController(
                              duration: const Duration(seconds: 2),
                            );
                            confettiController.play();

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder:
                                  (context) => Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      WinningBottomSheet(
                                        winnerLabel: "Team 1 wins",
                                        title: "Victory",
                                        message:
                                            "Amazing performance! Well played",
                                        finishButtonText: "New Game?",
                                        onFinish: () {
                                          confettiController.dispose();
                                          context.read<MrCubit>().resetGame();
                                          Navigator.of(
                                            context,
                                          ).popUntil((route) => route.isFirst);
                                        },
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 0,
                                        right: 100,
                                        child: ConfettiWidget(
                                          confettiController:
                                              confettiController,
                                          blastDirection: -pi / 10,
                                          emissionFrequency: 0.10,
                                          numberOfParticles: 20,
                                          maxBlastForce: 20,
                                          minBlastForce: 5,
                                          gravity: 0.1,
                                          shouldLoop: false,
                                          colors: const [
                                            Colors.red,
                                            Colors.blue,
                                            Colors.green,
                                            Colors.orange,
                                            Colors.purple,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


//? first change blocbuilder add it in all scaffold maybe
//* then look randomcode thing working or not and make it work
//! then complete other states (vairables that need changing with state cubit)









// TODO
 // so first of all make the qr code shuffle and create random code everytime
 //then finish the UI of room screen
        //add timer,
        //team and scores side by side
        //palyer names and in what team as in ui of picture
        //then create a page to add the of the math (basic ui for now)
        //then implement firestore or firebase for and Cubit ...



        //firebase
        /*
        Structure data in firebase
        ___________________
        rooms (collection)
            └ roomId (document)
                ├ name: "ABCD"
                ├ targetScore: 100
                ├ time: 30
                ├ players (subcollection)
                |     └ playerId
                |         ├ name: "Ihab"
                |         └ score: 0
                └ status: "waiting" / "playing" / "finished"
        ___________________

       - Each room has a unique code or QR.

       -  Players can only join if the room exists and is not full.

       -  Use Firestore real-time streams to update scores and timer.

    ___________________    ___________________    ___________________

    Room join Logic:
       When creating a room:

        - Generate a random code (like your QR code).

        - Store room info in Firestore.

      and user when types code if exists join else see if full or invalid



    ___________________    ___________________    ___________________

MINIMAL ROADMAP:
    1-Firebase setup (console + Flutter dependencies)

    2-Create room + generate QR → store in Firestore

    3-Join room logic → validate code → add player

    4-Room screen → listen to Firestore → update scores and timer

    5-Score increment → update Firestore → automatically reflected for all

    6-Optional: Add status field for game started / ended
 ___________________    ___________________    ___________________







        */