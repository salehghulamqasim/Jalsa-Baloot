import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playbaloot/src/core/cubit/mr_cubit.dart';
import 'package:playbaloot/src/features/create/presentation/widgets/FormFields.dart';
import 'package:playbaloot/src/features/intros/presentation/widgets/intro_icon_with_text.dart';
import 'package:playbaloot/src/features/room/presentation/pages/roomScreen.dart';
import 'package:flutter/cupertino.dart';

class Createscreen extends StatefulWidget {
  const Createscreen({super.key});

  @override
  State<Createscreen> createState() => _CreatescreenState();
}

class _CreatescreenState extends State<Createscreen> {
  String _selectedValue = '30 minutes';
  final List<String> _timeOptions = [
    '15 minutes',
    '30 minutes',
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours',
    '5 hours',
  ];

  void _showCupertinoPicker() {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 280,
            color: Colors.white,
            child: CupertinoPicker(
              itemExtent: 50,
              scrollController: FixedExtentScrollController(
                initialItem: _timeOptions.indexOf(_selectedValue),
              ),
              onSelectedItemChanged: (index) {
                HapticFeedback.mediumImpact();
                setState(() {
                  _selectedValue = _timeOptions[index];
                });
              },
              children:
                  _timeOptions.map((e) => Center(child: Text(e))).toList(),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Create Room',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                ),
                const SizedBox(height: 38),

                Column(
                  children: [
                    //*in future add number of players so people can add more than 4 players if they wish
                    // FormLabeledField(
                    //   label: "Number of players",
                    //   hintOrValue: "4",
                    //   isRequired: true,
                    // ),

                    //TODO Make the admin name be saved in the game as player team1 [0]
                    FormLabeledField(
                      label: "Admin Name",
                      hintOrValue: "Onwer of the room",
                      isRequired: true,
                    ),
                    const SizedBox(height: 22),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Choose Time",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: _showCupertinoPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE5E5EA)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedValue,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            const Icon(Icons.expand_more),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                    FormLabeledField(
                      label: "Target Score",
                      isRequired: true,
                      hintOrValue: "100 points",
                      onChanged: (value) {
                        final score = int.tryParse(value);
                        if (score != null) {
                          //null check
                          context.read<MrCubit>().setTargetScore(
                            score,
                          ); //then pass score directly
                        }
                        //Find my MrCubit in the widget tree, and tell it to update the target score with this new value.
                        // we added if else so if score is not empty then do updating else dont .
                      },
                    ),
                    const SizedBox(height: 220),

                    AppleStyleButton(
                      label: "Create a Room ",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Roomscreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
