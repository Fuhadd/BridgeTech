import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/models.dart';
import '../Widgets/constant_widget.dart';
import '../Widgets/navigation_drawer.dart';

class IDScreen extends StatelessWidget {
  const IDScreen({Key? key, required this.currentUser}) : super(key: key);
  final AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: NavigationDrawer(
        pageIndex: 7,
        // user: currentUser,
      ),
      appBar: MessageAppar(context, 'ID', currentUser.imageUrl),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5, offset: Offset(5, 5), color: Colors.grey),
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(-5, -5),
                      color: Colors.grey),
                  //BoxShadow(color: white, offset: const Offset(5, 0)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 30.0, left: 30, top: 30, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleText(
                      title: "${currentUser.lastName} ${currentUser.firstName}"
                          .toUpperCase(),
                      size: 25,
                    ),
                    verticalSpacer(5),
                    Text(
                      currentUser.skills?[0] ?? "Developer",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    verticalSpacer(30),
                    Row(
                      children: [
                        horizontalSpacer(10),
                        SizedBox(
                            width: 70,
                            child: Text(
                              "GITHUB:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                            )),
                        SubTitleText(
                          title: currentUser.lastName,
                          size: 19,
                        ),
                      ],
                    ),
                    verticalSpacer(8),
                    Row(
                      children: [
                        horizontalSpacer(10),
                        SizedBox(
                            width: 70,
                            child: Text(
                              "EMAIL:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                            )),
                        FittedBox(
                          child: SubTitleText(
                            title: currentUser.email,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                    verticalSpacer(8),
                    Row(
                      children: [
                        horizontalSpacer(10),
                        SizedBox(
                            width: 70,
                            child: Text(
                              "PHONE:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                            )),
                        SubTitleText(
                          title: "(+234) ${currentUser.phone}",
                          size: 16,
                        ),
                      ],
                    ),
                    verticalSpacer(30),
                    Row(
                      children: [
                        Container(
                          width: 110,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/Logo.png'))),
                        ),
                        horizontalSpacer(5),
                        SubTitleText(
                          title: "BRIDGETECH ADVANCE",
                          size: 13,
                        ),
                      ],
                    ),
                    verticalSpacer(25)
                  ],
                ),
              ),
            ),
            verticalSpacer(20),
            QrImage(
              data: currentUser.firstName,
              backgroundColor: background,
              size: 150,
            )
          ],
        ),
      ),
    );
  }
}
