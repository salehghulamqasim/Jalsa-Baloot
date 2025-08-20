import 'package:flutter/material.dart';

import '../../../intros/presentation/widgets/intro_icon_with_text.dart';

class RoundScoreBottomSheet extends StatefulWidget {
  final String title;
  final String teamALabel;
  final String teamBLabel;
  final void Function(int teamAScore, int teamBScore)? onSubmit;
  final VoidCallback? onCancel;
  final String submitButtonText;
  final String cancelButtonText;

  //constructor
  const RoundScoreBottomSheet({
    super.key,
    this.title = 'Round Over',
    this.teamALabel = 'Team 1',
    this.teamBLabel = 'Team 2',
    this.onSubmit,
    this.onCancel,
    this.submitButtonText = 'Next Round',
    this.cancelButtonText = 'Cancel',
  });

  @override
  State<RoundScoreBottomSheet> createState() => _RoundScoreBottomSheetState();
}

class _RoundScoreBottomSheetState extends State<RoundScoreBottomSheet> {
  late final TextEditingController teamAController;
  late final TextEditingController teamBController;

  @override
  void initState() {
    super.initState();
    teamAController = TextEditingController();
    teamBController = TextEditingController();
  }

  @override
  void dispose() {
    teamAController.dispose();
    teamBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    String title = "title";
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grab handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDDEE3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D1D1F),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Enter the scores for this round',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0x991D1D1F),
              ),
            ),
            const SizedBox(height: 24),

            // Team A Score Input
            _buildScoreInput(
              label: widget.teamALabel,
              controller: teamAController,
            ),
            const SizedBox(height: 16),

            // Team B Score Input
            _buildScoreInput(
              label: widget.teamBLabel,
              controller: teamBController,
            ),
            const SizedBox(height: 32),

            // Submit Button
            AppleStyleButton(
              label: widget.submitButtonText,
              onPressed: () {
                final teamAScore =
                    int.tryParse(teamAController.text.trim()) ?? 0;
                final teamBScore =
                    int.tryParse(teamBController.text.trim()) ?? 0;
                widget.onSubmit?.call(teamAScore, teamBScore);
              },
            ),
            const SizedBox(height: 12),

            // Cancel Button
            Center(
              child: TextButton(
                onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
                child: Text(
                  widget.cancelButtonText,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF007AFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreInput({
    required String label,
    required TextEditingController controller,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E5EA), width: 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D1D1F),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: TextStyle(
              color: Color(0x991D1D1F),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Color(0xFF007AFF), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// Helper function to show the bottom sheet
Future<void> showRoundScoreBottomSheet({
  required BuildContext context,
  String title = 'Round Over',
  String teamALabel = 'Team A',
  String teamBLabel = 'Team B',
  void Function(int teamAScore, int teamBScore)? onSubmit,
  VoidCallback? onCancel,
  String submitButtonText = 'Next Round',
  String cancelButtonText = 'Cancel',
}) async {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => RoundScoreBottomSheet(
          title: title,
          teamALabel: teamALabel,
          teamBLabel: teamBLabel,
          onSubmit: onSubmit,
          onCancel: onCancel,
          submitButtonText: submitButtonText,
          cancelButtonText: cancelButtonText,
        ),
  );
}

// Usage Example:
/*
await showRoundScoreBottomSheet(
  context: context,
  title: 'Round 3 Complete',
  teamALabel: 'Red Team',
  teamBLabel: 'Blue Team',
  onSubmit: (teamAScore, teamBScore) {
    // Handle scores here - integrate with your cubit
    print('Team A: $teamAScore, Team B: $teamBScore');
  },
  onCancel: () {
    Navigator.of(context).pop();
  },
  submitButtonText: 'Continue',
);
*/





// ! UNDERSTADNIGN THIS FILE
/*

   this file creates a bottomsheet widget where we add team 1 and 2 scores after round finished
   think of it as popup panel with two fields

   ? Main parts


   * RoundScoreBottomSheet - widget

     a stateful widget with customizable options for labels,title,button text
     takes a callbacks onSubmit and onCancel

   * State (_RoundScoreBottomSheetState)

      Holds textEditingControllers for each score input field
          Team 1
          Team 2

      They are created in initState and disposed by dispose

   * UI layout inside Build

      roudn white container with padding
      ....
      .....

   * Helper _buildScoreInput

      reusable method for creating styled textfield with label +input
      each teams input uses a different controller so values dont clash

   * showRoundScoreBottomSheet (function)

      a helper to actually show this widget as modal bottom sheet
      you call this function from anywhere in the app, it will pop up the score entry sheet







*/