import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../controllers/home_controller.dart';

class BuildDataTable extends StatelessWidget {
  const BuildDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            BuildHeader(),
            SizedBox(
              height: 10,
            ),
            BuildFooter()
          ],
        ),
      ),
    );
  }
}

/*
return SizedBox(
      height: 350,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            BuildHeader(),
            SizedBox(
              height: 10,
            ),
            BuildFooter()
          ],
        ),
      ),
    );
 */

class BuildHeader extends GetView<HomeController> {
  List<String> datColumn = [
    LocaleKeys.show.tr,
    LocaleKeys.notifiNo.tr,
    LocaleKeys.notifiDateG.tr,
    LocaleKeys.customer.tr,
    LocaleKeys.route.tr,
    LocaleKeys.containers.tr,
    LocaleKeys.shahena.tr,
    LocaleKeys.notificStatus.tr,
    LocaleKeys.badelDezal.tr,
    LocaleKeys.badelTariq.tr,
    LocaleKeys.additionalBadel.tr,
    LocaleKeys.total.tr,
    LocaleKeys.payment.tr,
    LocaleKeys.net.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.green,
          alignment: Alignment.center,
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[2],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[3],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[4],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[5],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[6],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[7],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[8],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[9],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[10],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[11],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  datColumn[12],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  datColumn[13],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildRowData extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      //width: 90,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Container(
              width: 130,
              padding: EdgeInsets.all(12),
              color: Color(0xFFE8F5E9),
              alignment: Alignment.center,
              child: Text(
                'yy',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
          separatorBuilder: (_, index) => Container(
                height: 70,
                width: 1,
                color: Colors.black26,
              ),
          itemCount: 55),
    );
  }
}

class BuildFooter extends GetView<HomeController> {
  List<String> dataFooter = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    LocaleKeys.badelDezal.tr,
    LocaleKeys.badelTariq.tr,
    LocaleKeys.additionalBadel.tr,
    LocaleKeys.total.tr,
    LocaleKeys.payment.tr,
    LocaleKeys.net.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          //  physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Container(
              width: 130,
              padding: EdgeInsets.all(12),
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                dataFooter[index],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
          separatorBuilder: (_, index) => Container(
                height: 70,
                width: 1,
                color: Colors.black26,
              ),
          itemCount: dataFooter.length),
    );
  }
}
