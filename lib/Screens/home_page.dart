import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';
import 'package:urban_hive_test/Widgets/non_included_screen.dart';

import '../Config/Repositories/user_repository.dart';
import '../Models/models.dart';
import '../Widgets/constant_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';
  // final AppUser currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser? currentUser;

  Future<AppUser> getMyInfoFromSharedPreference() async {
    currentUser = await UserRepository().fetchCurrentUser();
    return currentUser!;
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
  }

  @override
  void initState() {
    // currentUser = getMyInfoFromSharedPreference().th;

    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    // doThisOnLaunch();
    // TODO: implement initState
    super.initState();
  }

  // List users = User.users;
  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? Scaffold(body: Center(child: loader()))
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              backgroundColor: background,
              drawer: NavigationDrawer(
                pageIndex: 1,
                // user: currentUser!,
              ),
              appBar: MessageAppar(context, 'Dashboard', currentUser!.imageUrl),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      verticalSpacer(26),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            // BoxShadow(
                            //     blurRadius: 5,
                            //     offset: Offset(5, 5),
                            //     color: Colors.grey),
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(-7, -7),
                                color: Colors.grey),
                            //BoxShadow(color: white, offset: const Offset(5, 0)),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          //border: Border.all(),
                          color: const Color.fromRGBO(255, 189, 89, 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubTitleText(
                                      title: 'Active Users',
                                    ),
                                    verticalSpacer(5),
                                    Text(
                                      "Number of users online",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    verticalSpacer(15),
                                    Row(
                                      children: [
                                        TitleText(title: '645'),
                                        horizontalSpacer(10),
                                        Text(
                                          "+5.25%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpacer(15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SubTitleText(title: "9.5k"),
                                      Text(
                                        "Users",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SubTitleText(title: "6.8k"),
                                      Text(
                                        "Requests",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SubTitleText(title: "1.2k"),
                                      Text(
                                        "Matches",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpacer(15),
                      const Divider(
                        thickness: 1,
                        endIndent: 30,
                        indent: 30,
                        color: Colors.black,
                      ),
                      verticalSpacer(15),
                      UserDropdownBox("Co-Founder Matches"),
                      verticalSpacer(20),
                      UserDropdownBox("Co-Founder Requests"),
                      verticalSpacer(20),
                      UserDropdownBox("Saved Profiles"),
                      verticalSpacer(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          //height: 90,
                          child: Column(
                            children: [
                              SubTitleText(
                                title: "Recent Messages",
                                size: 20,
                              ),
                              verticalSpacer(10),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(Conversation
                                          .conversations[0].imageUrl),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SubTitleText(
                                              title: Conversation
                                                  .conversations[0].name,
                                              size: 21,
                                            ),
                                            verticalSpacer(6),
                                            Text(
                                              Conversation
                                                  .conversations[0].content,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                            ),
                                            verticalSpacer(30),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Container UserDropdownBox(String title) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 5, offset: Offset(2, 5), color: Colors.grey),
            // BoxShadow(offset: const Offset(-5, 0), color: white),
            // BoxShadow(color: white, offset: const Offset(5, 0)),
          ]),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: DropdownButton<dynamic>(
            isExpanded: true,

            icon: const Icon(
              FontAwesomeIcons.caretDown,
              size: 25,
            ),
            itemHeight: 230,
            //menuMaxHeight: 100,
            hint: SubTitleText(
              title: title,
              size: 18,
            ),
            onChanged: (value) => setState(() {}),
            items: User1.users
                .map(
                  (user) => CustomDropdownMenu(user),
                )
                .toList(),
          )),
    );
  }

  DropdownMenuItem<dynamic> CustomDropdownMenu(User1 user) {
    return DropdownMenuItem(
        value: user,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            //height: 90,
            child: Column(
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubTitleText(title: user.name),
                            verticalSpacer(6),
                            const Text("Matched 5 days Ago"),
                            verticalSpacer(15),
                            Text(
                              user.bio,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                            ),
                            verticalSpacer(20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SmallCustomButton(title: "MANAGE"),
                      // horizontalSpacer(10),
                      SmallCustomButton(title: "MESSAGE"),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
        // ListTile(
        //   horizontalTitleGap: 40,
        //   contentPadding: EdgeInsets.all(10),

        //   title: SubTitleText(title: user.name),
        //   //Text(Conversation.conversations[index].name),
        //   leading: CircleAvatar(
        //     backgroundImage: NetworkImage(user.imageUrl),
        //   ),
        //   //subtitle: Text(user.content),
        // ),
        );
  }
// DropdownMenuItem customBuildMenuItem(User e) {}
}

class _CustomCurvedBar extends StatelessWidget {
  const _CustomCurvedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 210,
          decoration: const BoxDecoration(color: Colors.purple),
        ),
      ),
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
    ]);
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstController = Offset(0, size.height - 90);
    var firstEnd = Offset(size.width / 4, size.height - 90);
    path.quadraticBezierTo(
      firstController.dx,
      firstController.dy,
      firstEnd.dx,
      firstEnd.dy,
    );
    path.lineTo(size.width - 100, size.height - 90);
    var secondController = Offset(size.width - 55, size.height - 90);
    var secondEnd = Offset(size.width, size.height - 140);
    path.quadraticBezierTo(
      secondController.dx,
      secondController.dy,
      secondEnd.dx,
      secondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  InputDecoration formDecoration = const InputDecoration(
      floatingLabelStyle: TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        Icons.mail,
        size: 20,
      ),
      labelText: 'Gender');
}
