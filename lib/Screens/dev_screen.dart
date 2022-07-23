import 'package:flutter/material.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../Helpers/colors.dart';

class DevScreen extends StatelessWidget {
  const DevScreen({Key? key, required this.currentUser}) : super(key: key);
  static const routeName = '/dev';
  final AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: const NavigationDrawer(
        pageIndex: 2,
        // user: currentUser,
      ),
      appBar: CustomAppar(context, 'Book Dev'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              verticalSpacer(10),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(249, 245, 229, 1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 10),
                            color: Colors.grey.withOpacity(0.5)),
                      ]),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 35,
                ),
              ),
              verticalSpacer(30),
              mainDivider(),
              verticalSpacer(20),
              const TitleText(
                title: 'Fullstack Developer',
              ),
              verticalSpacer(10),
              customFormBuilderRadioGroup('Date', 'Wednesday'),
              verticalSpacer(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TimeContainer(
                      time: '09:00',
                    ),
                    TimeContainer(
                      time: '10:00',
                    ),
                    TimeContainer(
                      time: '11:00',
                    ),
                    TimeContainer(
                      time: '12:00',
                    ),
                  ],
                ),
              ),
              verticalSpacer(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TimeContainer(
                      time: '13:00',
                    ),
                    TimeContainer(
                      time: '14:00',
                    ),
                    TimeContainer(
                      time: '15:00',
                    ),
                    TimeContainer(
                      time: '16:00',
                    ),
                  ],
                ),
              ),
              verticalSpacer(20),
              mainDivider(),
              verticalSpacer(20),
              const TitleText(
                title: 'Flutter Developer',
              ),
              verticalSpacer(10),
              customFormBuilderRadioGroup('Date', 'Tuesday'),
              verticalSpacer(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TimeContainer(
                      time: '09:00',
                    ),
                    TimeContainer(
                      time: '10:00',
                    ),
                    TimeContainer(
                      time: '11:00',
                    ),
                    TimeContainer(
                      time: '12:00',
                    ),
                  ],
                ),
              ),
              verticalSpacer(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TimeContainer(
                      time: '13:00',
                    ),
                    TimeContainer(
                      time: '14:00',
                    ),
                    TimeContainer(
                      time: '15:00',
                    ),
                    TimeContainer(
                      time: '16:00',
                    ),
                  ],
                ),
              ),
              verticalSpacer(20),
              mainDivider(),
              // verticalSpacer(10),
              // customFormBuilderRadioGroup('Date', 'Tuesday'),
              // customFormBuilderChoiceChip(context, 'time'),
              // mainDivider(),
              verticalSpacer(150),
              Row(
                children: [
                  horizontalSpacer(15),
                  const CustomButton(
                    title: 'CONFIRM BOOKING',
                  ),
                  horizontalSpacer(20),
                  const CustomButton(
                    title: 'RESET',
                  ),
                ],
              ),
              verticalSpacer(40),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  final String time;
  const TimeContainer({
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      //width: 60,
      child: Text(
        time,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }
}
