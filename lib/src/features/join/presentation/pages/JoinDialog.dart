import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:playbaloot/src/features/create/presentation/widgets/FormFields.dart';
import 'package:playbaloot/src/features/intros/presentation/widgets/intro_icon_with_text.dart';
// class Joinscreen extends StatelessWidget {
//   const Joinscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {

//             Navigator.pop(context); //to go back to previous page
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       backgroundColor: const Color(0xFFF7F7F7),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(0),
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Join Room',
//                   style: TextStyle(
//                     fontSize: 45,
//                     fontWeight: FontWeight.w700,
//                     fontFamily: 'SF Pro Display',
//                   ),
//                 ),
//                 const SizedBox(height: 38),
//                 //this page will have qrimage to show camera to scacn qr code
//                 // and will have one button that says type code manually
//                 // Expanded(
//                 //   child: AspectRatio(
//                 //     aspectRatio: 3 / 4,
//                 //     child: ClipRRect(
//                 //       borderRadius: BorderRadius.circular(22),
//                 //       child: MobileScanner(
//                 //           onDetect: (capture) {
//                 //             final List<Barcode> barcodes = capture.barcodes;
//                 //             for (final barcode in barcodes) {
//                 //               // ignore: avoid_print
//                 //               print("barcod found and its data are ${barcode.rawValue}");
//                 //             }
//                 //           },
//                 //         ),
//                 //     ),
//                 //   ),
//                 // )

//               ],
//             ),

//         ),

//       ),
//     )
//     )
//     ;
//   }
// }

// page_b_dialog.dart

// Reusable function you can call from anywhere
Future<void> joinDialog(BuildContext context) {
  // return showDialog(
  //   context: context,
  //   builder:
  //       (_) => Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               AspectRatio(
  //                 aspectRatio: 1, // square
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(16),

  //                   child: MobileScanner(
  //                     onDetect: (capture) {
  //                       //add code for sending the code to backend to join room

  //                       // for (final barcode in capture.barcodes) {
  //                       //   final v = barcode.rawValue;
  //                       //   if (v != null && v.isNotEmpty) {
  //                       //     print('barcode: $v');
  //                       //   }
  //                       // }
  //                     },
  //                   ),
  //                 ),
  //               ),

  //               const SizedBox(height: 12),

  //               // TextButton(
  //               //   onPressed: () {},
  //               //   child: Text("Wanna add code manauly?"),
  //               // ),
  //               FormLabeledField(
  //                 label: "Scan Qr code or type the code below",
  //                 isRequired: false,
  //                 hintOrValue: "type the room code here",
  //                 keyboardType: TextInputType.number,
  //               ),
  //               SizedBox(height: 12),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Close"),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  // );
  return showGeneralDialog(
    context: context,
    barrierDismissible:
        true, // If true, the user can tap the darkened background (barrier) to dismiss the dialog
    barrierLabel:
        '', // Accessibility label for the barrier (screen readers). Empty means no label.
    barrierColor: Colors.black.withOpacity(
      0.4,
    ), // Color of the dimmed background behind the dialog
    transitionDuration: Duration(
      milliseconds: 200,
    ), // How long the animation takes when the dialog appears or disappears
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // This function defines how the dialog animates in and out
      // 'animation' goes from 0.0 (hidden) to 1.0 (fully shown)
      return Transform.scale(
        scale: animation.value, // Scale up from 0 to 1
        child: Opacity(
          opacity: animation.value, // Fade in from transparent to opaque
          child: child, // This is the actual dialog (built by pageBuilder)
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      // This function returns the widget to show inside the dialog
      // It's called once when the dialog is created
      return Center(
        // Center the dialog on the screen
        child: Material(
          color: Color(0xFFF7F7F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          elevation: 4, //add shadow
          child: SizedBox(
            width: 360,

            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1, // square
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: MobileScanner(
                        onDetect: (capture) {
                          //add code for sending the code to backend to join room

                          // for (final barcode in capture.barcodes) {
                          //   final v = barcode.rawValue;
                          //   if (v != null && v.isNotEmpty) {
                          //     print('barcode: $v');
                          //   }
                          // }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text("Wanna add code manauly?"),
                  // ),
                  Text(
                    'Scan QR code or type the code below',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),

                  FormLabeledField(
                    label: "",
                    isRequired: false,
                    hintOrValue: "Type the room code here",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 14),
                  AppleStyleButton(label: "Submit", onPressed: () {}),
                  const SizedBox(height: 28),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), // Main content message,
      );
    },
  );
}

//showgeneraldialog
 /*
    pageBuilder puts a actor (dialog) on stage
    transitionBuilder adds the spotlight and entrance animation
    the Barrier is darkened audience area
    the BarrierDismissible decides whether callping (tapping) ends the show early


 */