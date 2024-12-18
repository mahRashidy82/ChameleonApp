import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controllers/home_controller.dart';

class BuildFlowWidget extends GetView<HomeController> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool rmIcons = false;
  bool rmIcons2 = false;
  VoidCallback? onTapHorizontal;
  VoidCallback? vertival;
  VoidCallback? grid;

  BuildFlowWidget({
    required this.onTapHorizontal,
    required this.vertival,
    required this.grid,

  });

  Widget build(BuildContext context) {
    return SpeedDial(
      closeDialOnPop: true,
      icon: Icons.select_all_rounded,
      activeIcon: Icons.close,
      backgroundColor: Colors.white,
      openCloseDial: isDialOpen,


      spaceBetweenChildren: 4,
      buttonSize: Size(46.0, 46.0),
      childrenButtonSize: Size(46.0, 46.0),

      visible: true,
      direction: SpeedDialDirection.down,
      switchLabelPosition: false,
      closeManually: false,
      renderOverlay: false,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      useRotationAnimation: false,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        SpeedDialChild(
          child: !rmIcons ? const Icon(Icons.horizontal_split_outlined) : null,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          //label: 'Add',
          onTap: onTapHorizontal,
        ),
        SpeedDialChild(
          child: !rmIcons ? const Icon(Icons.vertical_split_outlined) : null,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          // label: 'Second',
          onTap: vertival,
        ),
        SpeedDialChild(
          child: !rmIcons ? const Icon(Icons.grid_on_outlined) : null,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          // label: 'Show Snackbar',
          visible: true,
          onTap: grid,
        ),
      ],
    );
  }
}
