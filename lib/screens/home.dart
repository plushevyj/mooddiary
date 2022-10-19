import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '/layout/custom_colors.dart' as custom_colors;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 70,
            expandedHeight: 400,
            backgroundColor: custom_colors.appBarColor,
            leading: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: CircleAvatar(backgroundColor: Color(0xFFFFFFFF)),
            ),
            leadingWidth: 50,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.only(bottom: 25, left: _horizontalTitlePadding, right: _horizontalTitlePadding),
              title: Text(
                'October 7, 2022',
                style: GoogleFonts.readexPro(color: const Color(0xFFFFFFFF)),
              ),
              background: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                  child: TableCalendar(
                    currentDay: DateTime.now(),
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(2020, 1, 1),
                    lastDay: DateTime(2025, 12, 31),
                    headerVisible: false,
                    rowHeight: 40,

                  ),
                ),
              ),
            ),
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
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [for (int i = 0; i < 50; i++) const Text('kek')],
              ),
            ),
          )
        ],
      ),
    );
  }

  double get _horizontalTitlePadding {
    const kBasePadding = 15.0;
    const kMultiplier = 0.8;
    const kExpandedHeight = 370;

    if (_scrollController.hasClients) {
      // In case 50%-100% of the expanded height is viewed
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        return kBasePadding;
      }
      // In case 0% of the expanded height is viewed
      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
            kBasePadding;
      }
      // In case 0%-50% of the expanded height is viewed
      return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
          kBasePadding;
    }
    return kBasePadding;
  }
}
