// // Automatic FlutterFlow imports
// // Begin custom widget code
// // DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:crop_your_image/crop_your_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '/backend/backend.dart';
// import '/backend/schema/enums/enums.dart';
// import '/backend/schema/structs/index.dart';
// import '/custom_code/actions/index.dart'; // Imports custom actions
// import '/custom_code/widgets/index.dart'; // Imports other custom widgets
// import '/flutter_flow/custom_functions.dart'; // Imports custom functions
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';

// class ImageCropper extends StatefulWidget {
//   const ImageCropper({
//     super.key,
//     this.width,
//     this.height,
//     this.imageFile,
//     this.callBackAction,
//     this.currentUserId,
//   });

//   final double? width;
//   final double? height;
//   final String? imageFile;
//   final Future Function(String? url)? callBackAction;
//   final String? currentUserId;

//   @override
//   State<ImageCropper> createState() => _ImageCropperState();
// }

// class _ImageCropperState extends State<ImageCropper> {
//   Uint8List? imageBytes;
//   bool loading = false;
//   bool imageLoading = true;
//   final _cropController = CropController();
//   // final CropController _cropController = CropController();

//   @override
//   void initState() {
//     super.initState();
//     loadImage();
//   }

//   Future<void> loadImage() async {
//     setState(() {
//       imageLoading = true;
//     });
//     imageBytes =
//         widget.imageFile != null ? base64Decode(widget.imageFile!) : null;
//     setState(() {
//       imageLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: widget.width ?? double.infinity,
//           height: (widget.height ?? 555) - 80,
//           child: Center(
//             child: imageLoading
//                 ? CircularProgressIndicator()
//                 : Crop(
//                     image: imageBytes!,
//                     controller: _cropController,
//                     onCropped: (image) async {
//                       await widget.callBackAction?.call(base64Encode(image));
//                       setState(() {
//                         loading = false;
//                       });
//                     },
//                     aspectRatio: 3.33,
//                     initialSize: 1,
//                     interactive: true,
//                     fixCropRect: true,
//                     // withCircleUi: true,
//                     baseColor: Color.fromARGB(255, 0, 3, 22),
//                     maskColor: null,
//                     // radius: 20,
//                     onMoved: (newRect) {
//                       // do something with current cropping area.
//                     },
//                     onStatusChanged: (status) {
//                       // do something with current CropStatus
//                     },
//                     cornerDotBuilder: (size, edgeAlignment) =>
//                         const SizedBox.shrink(),
//                     initialRectBuilder: (viewportRect, imageRect) {
//                       return Rect.fromLTRB(
//                         viewportRect.left + 24,
//                         viewportRect.top + 24,
//                         viewportRect.right - 24,
//                         viewportRect.bottom - 24,
//                       );
//                     },
//                   ),
//           ),
//         ),
//         Positioned(
//           top: 250, // Posicione conforme necessário
//           left: MediaQuery.of(context).size.width / 7,
//           child: ClipOval(
//             child: Container(
//               width: 85, // Tamanho desejado do círculo
//               height: 85, // Tamanho desejado do círculo
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 4,
//           right: 4,
//           child: IconButton(
//             icon: Icon(Icons.fork_right),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//       ],
//     );
//   }
// }
