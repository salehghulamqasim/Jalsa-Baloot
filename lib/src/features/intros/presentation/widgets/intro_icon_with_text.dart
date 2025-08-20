import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class IntroIconWithText extends StatelessWidget {
  final String iconPath;
  final String label;
  final double iconSize; // NEW
  final double textSize; // NEW
  final Color iconColor;

  const IntroIconWithText({
    super.key,
    required this.iconPath,
    required this.label,
    this.iconSize = 100, //size of the image or icons
    this.textSize = 26,
    this.iconColor = Colors.black, // default color for the icon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          height: iconSize,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: textSize, height: 1.25),
          ),
        ),
      ],
    );
  }
}

class FancyButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FancyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 12),
                Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppleStyleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AppleStyleButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // full width like screenshot
      height: 56, // height from screenshot
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007AFF), // iOS blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0, // flat like Apple buttons
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro Display',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
