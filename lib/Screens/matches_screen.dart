import 'package:flutter/material.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';
import 'package:urban_hive_test/Widgets/non_included_screen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key, required this.currentUser}) : super(key: key);
  final AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    return NonIncludedScreen(
      pageIndex: 3,
      apparTitle: 'Matches',
      mainText: 'Matches Screen',
      currentUser: currentUser,
    );
  }
}
