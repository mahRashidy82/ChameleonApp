import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../global/global_widget/my_text_button.dart';

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Colors.orange, size: 100),
            SizedBox(height: 20.0),
            Text(
              'You denied location permission , Please approve it',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20.0),
            Row(children: [
              Expanded(
                child: MyTextButton(
                  size: Size(double.infinity, 40),
                  onPressed: () => Navigator.pop(context),
                  text: 'Close',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: MyTextButton(
                  size: Size(double.infinity, 40),
                  onPressed: () async {
                    await Geolocator.openAppSettings();
                    Navigator.pop(context);
                  },
                  text: 'Settings',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
