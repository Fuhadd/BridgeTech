import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urban_hive_test/Config/Repositories/user_repository.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Screens/discover_test.dart';
import 'package:urban_hive_test/Screens/home_page.dart';
import 'package:urban_hive_test/Screens/inbox_screen.dart';
import 'package:urban_hive_test/Screens/matched_users_screen.dart';
import 'package:urban_hive_test/Screens/requests_screen.dart';
import 'package:urban_hive_test/Screens/settings.dart';
// import 'package:urban_hive_test/Screens/profile_screen.dart';

import '../Helpers/sharedPrefs.dart';
import '../Screens/id_card_screen.dart';
import '../Screens/verifyuserbio_screen.dart';

class NavigationDrawer extends StatefulWidget {
  final int pageIndex;
  const NavigationDrawer({Key? key, required this.pageIndex}) : super(key: key);
  //final AppUser? user;

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late AppUser currentUser;

  getMyInfoFromSharedPreference() async {
    currentUser = await UserRepository().fetchCurrentUser();
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
  }

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    // doThisOnLaunch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context, widget.pageIndex, currentUser),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/Logo.png'))),
  );
// //
}

class SideMenus extends StatelessWidget {
  SideMenus({
    this.padding = 16,
    this.color = Colors.white,
    required this.onClick,
    required this.icon,
    required this.title,
    //required onClick,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String title;
  double padding;
  Color color;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: padding),
      leading: Icon(
        icon,
        //Icons.home_outlined,
        color: color,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(fontWeight: FontWeight.w900, color: color),
      ),
      onTap: onClick,
    );
  }
}

Widget buildMenuItems(BuildContext context, int pageIndex, AppUser user) {
  return Column(
    children: [
      SideDivider(),
      SideMenus(
          color: pageIndex == 1
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.home_outlined,
          title: 'HOME',
          onClick: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(
                    // currentUser: user,
                    ),
              ),
            );
          }),
      // SideDivider(),
      // SideMenus(
      //     color: pageIndex == 2
      //         ? const Color.fromRGBO(255, 189, 89, 1)
      //         : Colors.white,
      //     icon: Icons.book_outlined,
      //     title: 'BOOK DEV',
      //     onClick: () {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => const UserProfileTestScreen(),
      //         ),
      //       );
      //     }),
      SideDivider(),
      SideMenus(
          color: pageIndex == 3
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.nature_people_outlined,
          title: 'MATCH',
          onClick: () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => MatchesScreen(
            //       currentUser: user,
            //     ),
            //   ),
            // );
          }),
      SideMenus(
          color: pageIndex == 4
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.person_outline_outlined,
          title: 'My Profile',
          padding: 40,
          onClick: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => VerifyBioScreen(
                        user: user,
                      )

                  // ProfileScreen(
                  //     // currentUser: user,
                  //     ),
                  ),
            );
          }),
      SideMenus(
          color: pageIndex == 5
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: FontAwesomeIcons.gears,
          title: 'Candidates',
          padding: 40,
          onClick: () async {
            int? initialPage =
                await SharedPreferenceHelper().getPageIndex() ?? 0;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => DiscoverTestScreen(
                    currentUser: user, initialPage: initialPage),
              ),
            );

            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => DiscoverTestScreen(currentUser: user),
            //   ),
            // );
          }),
      SideMenus(
          color: pageIndex == 6
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.message_outlined,
          title: 'Inbox',
          padding: 40,
          onClick: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Inboxscreen(
                  currentUser: user,
                ),
              ),
            );
          }),
      SideDivider(),
      SideMenus(
          color: pageIndex == 3
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.nature_people_outlined,
          title: 'CONNECTIONS',
          onClick: () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => MatchesScreen(
            //       currentUser: user,
            //     ),
            //   ),
            // );
          }),
      // SideMenus(
      //     color: pageIndex == 5
      //         ? const Color.fromRGBO(255, 189, 89, 1)
      //         : Colors.white,
      //     icon: Icons.people_outlined,
      //     title: 'Discover',
      //     padding: 40,
      //     onClick: () {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => DiscoverScreen(
      //             currentUser: user,
      //           ),
      //         ),
      //       );
      //     }),
      SideMenus(
          color: pageIndex == 9
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.people,
          title: 'Matched',
          padding: 40,
          onClick: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => MatchedUsersScreen(currentUser: user)),
            );
          }),
      // SideMenus(
      //     color: pageIndex == 13
      //         ? const Color.fromRGBO(255, 189, 89, 1)
      //         : Colors.white,
      //     icon: Icons.person_add_alt,
      //     title: 'Sent Requests',
      //     padding: 40,
      //     onClick: () {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => SentRequestScreen(currentUser: user),
      //         ),
      //       );
      //     }),

      SideMenus(
          color: pageIndex == 10
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: Icons.person_pin_outlined,
          title: 'Received',
          padding: 40,
          onClick: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => UserRequestsScreen(currentUser: user),
              ),
            );
          }),

      // SideMenus(
      //     color: pageIndex == 11
      //         ? const Color.fromRGBO(255, 189, 89, 1)
      //         : Colors.white,
      //     icon: Icons.cancel_outlined,
      //     title: 'Failed',
      //     padding: 40,
      //     onClick: () {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => FailedConnectScreen(currentUser: user),
      //         ),
      //       );
      //     }),

      SideDivider(),

      SideMenus(
          color: pageIndex == 7
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: FontAwesomeIcons.idCard,
          title: 'ID',
          onClick: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => IDScreen(
                  currentUser: user,
                ),
              ),
            );
          }),
      SideMenus(
          color: pageIndex == 8
              ? const Color.fromRGBO(255, 189, 89, 1)
              : Colors.white,
          icon: FontAwesomeIcons.gears,
          title: 'SETTINGS',
          onClick: () {
            Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
            // SharedPreferences preferences =
            //     await SharedPreferences.getInstance();
            // await preferences.remove('user');
            // UserRepository().logOut();
            // Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }),

      // SideMenus(
      //     color: pageIndex == 8
      //         ? const Color.fromRGBO(255, 189, 89, 1)
      //         : Colors.white,
      //     icon: FontAwesomeIcons.gears,
      //     title: 'SETTINGS',
      //     onClick: () async {
      //       int? initialPage =
      //           await SharedPreferenceHelper().getPageIndex() ?? 0;
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => DiscoverTestScreen(
      //               currentUser: user, initialPage: initialPage),
      //         ),
      //       );

      //       // Navigator.of(context).pushReplacement(
      //       //   MaterialPageRoute(
      //       //     builder: (context) => DiscoverTestScreen(currentUser: user),
      //       //   ),
      //       // );
      //     }),
    ],
  );
}
