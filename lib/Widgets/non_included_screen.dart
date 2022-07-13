import 'package:flutter/material.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

class NonIncludedScreen extends StatelessWidget {
  final String apparTitle;
  final String mainText;
  final int pageIndex;
  final AppUser currentUser;

  const NonIncludedScreen({
    required this.apparTitle,
    required this.mainText,
    required this.pageIndex,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        pageIndex: pageIndex,
      ),
      appBar: CustomAppar(context, apparTitle),
      // AppBar(
      //   iconTheme: const IconThemeData(color: Colors.black, size: 35),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     apparTitle,
      //     style: Theme.of(context)
      //         .textTheme
      //         .headline2!
      //         .copyWith(color: Colors.black),
      //   ),
      // ),
      body: NoContentWidget(mainText: mainText),
    );
  }
}

class NoContentWidget extends StatelessWidget {
  const NoContentWidget({
    Key? key,
    required this.mainText,
  }) : super(key: key);

  final String mainText;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.black),
        ),
        verticalSpacer(10),
        const Text('This screen was not included in the design'),
        verticalSpacer(10),
        Container(
          height: 80,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Error1.png'))),
        )
      ],
    ));
  }
}
