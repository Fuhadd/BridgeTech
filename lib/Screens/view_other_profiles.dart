import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/models.dart';

import '../Widgets/constant_widget.dart';

class ViewOtherProfiles extends StatelessWidget {
  ViewOtherProfiles({required this.buddyUser, Key? key}) : super(key: key);
  AppUser buddyUser;

  @override
  Widget build(BuildContext context) {
    {
      return SafeArea(
        top: true,
        right: false,
        left: false,
        bottom: false,
        child: Scaffold(
          appBar: MessageAppar(
              context, '${buddyUser.lastName}\'s profile', buddyUser.imageUrl),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
              child: Column(
                children: [
                  verticalSpacer(50),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        //color: Colors.blue,
                        width: double.infinity,
                        height: 230,
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
                          borderRadius: BorderRadius.circular(25),
                          // gradient: LinearGradient(colors: [
                          //   // Yellow.withOpacity(0.7),
                          //   // Yellow,
                          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          //border: Border.all(),
                          color: const Color.fromRGBO(255, 189, 89, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomSubTitleText(
                                title:
                                    '${buddyUser.lastName} ${buddyUser.firstName}',
                                color: Colors.white,
                                size: 25,
                              ),
                              verticalSpacer(10),
                              CustomSubTitleText(
                                fontWeight: FontWeight.w100,
                                title: buddyUser.skills?[0],
                                color: Colors.white,
                                size: 19,
                              ),
                              verticalSpacer(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpacer(20),
                                  const SmallCustomRowButton(
                                      icon: FontAwesomeIcons.locationDot,
                                      title: 'Nigeria'),
                                  SmallCustomRowButton(
                                      icon: FontAwesomeIcons.phone,
                                      title: (buddyUser.phone).toString()),
                                  horizontalSpacer(20),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Yellow,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Yellow,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(buddyUser.imageUrl),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpacer(30),
                  Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      color: Colors.white,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DiscoveredColumn(
                                title: 'Technical',
                                child: buddyUser.technical == "1"
                                    ? Icon(
                                        FontAwesomeIcons.circleCheck,
                                        color: Yellow,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.circle,
                                        color: Yellow,
                                      )),
                            horizontalSpacer(10),
                            const VerticalDivider(
                              indent: 20,
                              endIndent: 20,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            horizontalSpacer(10),
                            DiscoveredColumn(
                              title: 'Commitment (hrs)',
                              child: CustomSubTitleText(
                                  title: '20', color: Yellow, size: 19),
                            ),
                            horizontalSpacer(20),
                          ],
                        ),
                      )),
                  verticalSpacer(20),
                  CustomSubTitleText(
                    align: true,
                    title: 'General Information',
                    color: const Color(0xFF2B2E4A),
                  ),
                  verticalSpacer(15),
                  CustomBioText(
                    align: true,
                    title: buddyUser.bio!,
                    color: Colors.grey,
                  ),
                  verticalSpacer(30),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Container _UserInfoCard(String title) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.user,
                    color: Colors.grey,
                    size: 19,
                  ),
                  horizontalSpacer(10),
                  CustomSubTitleText(
                    title: 'Personal Information',
                    color: Colors.grey,
                    size: 19,
                  ),
                  horizontalSpacer(10),
                ],
              ),
              const Icon(
                FontAwesomeIcons.angleRight,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiscoveredColumn extends StatelessWidget {
  const DiscoveredColumn({Key? key, required this.child, required this.title})
      : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSubTitleText(
          title: title,
          color: Colors.grey,
          size: 20,
        ),
        verticalSpacer(9),
        child,
      ],
    );
  }
}

Future<dynamic> _showBottomSheet(BuildContext context, {AppUser? buddyUser}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSubTitleText(
                title: 'About ${buddyUser?.lastName}',
                color: const Color(0xFF2B2E4A),
              ),
              CustomSubTitleText(
                align: true,
                title: buddyUser!.bio!,
                color: Colors.grey,
                size: 16,
              )
            ],
          ),
        );
      });
}
