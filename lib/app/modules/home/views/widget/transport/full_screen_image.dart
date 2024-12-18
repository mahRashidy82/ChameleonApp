import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../global/controllers/language_controller.dart';

class FullScreenImage extends StatelessWidget {
  Uint8List url;

  FullScreenImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        InteractiveViewer(
          child: Image.memory(
            url,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Get.find<LanguageController>().isArabic ||
                        Get.find<LanguageController>().isUrdo ||
                        Get.find<LanguageController>().isHindi
                    ? Icons.arrow_forward
                    : Icons.arrow_back,
                color: Colors.black,
                size: 35,
              )),
        )
      ],
    ));
  }
}
