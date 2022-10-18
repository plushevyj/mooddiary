import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/layout/style.dart' as custom_colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
  }

  double get _horizontalTitlePadding {
    const kBasePadding = 15.0;
    const kMultiplier = 0.5;
    const kExpandedHeight = 200;

    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        // In case 50%-100% of the expanded height is viewed
        return kBasePadding;
      }

      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        // In case 0% of the expanded height is viewed
        return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
            kBasePadding;
      }

      // In case 0%-50% of the expanded height is viewed
      return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
          kBasePadding;
    }

    return kBasePadding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            collapsedHeight: 70,
            expandedHeight: 200,
            backgroundColor: custom_colors.appBarColor,
            leading: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: CircleAvatar(backgroundColor: Color(0xFFFFFFFF)),
            ),
            leadingWidth: 50,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: _horizontalTitlePadding),
              // centerTitle: true,
              title: Text(
                'October 7, 2022',
                style: GoogleFonts.readexPro(color: const Color(0xFFFFFFFF)),
              ),
            ),
            centerTitle: true,
            actions: const [
              Icon(Icons.search, color: Color(0xFFFFFFFF)),
              SizedBox(width: 15),
              Icon(Icons.more_vert, color: Color(0xFFFFFFFF)),
              SizedBox(width: 10),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Increment value is: '),
                  SizedBox(height: 10),
                  Text('10'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
