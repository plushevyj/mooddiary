import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../layout/month.dart';
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
    print(_horizontalTitlePadding);
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
              titlePadding: EdgeInsets.only(
                bottom: 25,
                right:
                    MediaQuery.of(context).size.width / _horizontalTitlePadding,
              ),
              centerTitle: true,
              title: Text(
                '${month[DateTime.now().month]} ${DateTime.now().day}, ${DateTime.now().year}',
                style: GoogleFonts.readexPro(color: const Color(0xFFFFFFFF)),
              ),
              background: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: TableCalendar(
                    currentDay: DateTime.now(),
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(2020, 1, 1),
                    lastDay: DateTime(2025, 12, 31),
                    pageJumpingEnabled: true,
                    headerVisible: false,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    rowHeight: 40,
                    daysOfWeekHeight: 40,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle:
                          GoogleFonts.readexPro(color: const Color(0xFFFFFFFF)),
                      weekendStyle:
                          GoogleFonts.readexPro(color: const Color(0xFFFFFFFF)),
                    ),
                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      outsideTextStyle: TextStyle(color: Color(0x00000000)),
                      weekendTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      todayDecoration : BoxDecoration(
                        color: Color(0xFF6C33CA),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: const [
              Icon(Icons.search, color: Color(0xFFFFFFFF)),
              SizedBox(width: 25),
              Icon(Icons.more_vert, color: Color(0xFFFFFFFF)),
              SizedBox(width: 15),
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
                children: [
                  for (int i = 0; i < 50; i++)
                    const Text(
                      'kek',
                      style: TextStyle(color: Color(0x00000000)),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double get _horizontalTitlePadding {
    const kBasePadding = 3.5;
    const kMultiplier = 0.5;
    const kExpandedHeight = 370;
    const kScrollCoefficient = 1.5;

    if (_scrollController.hasClients) {
      // In case 50%-100% of the expanded height is viewed
      if (_scrollController.offset < (kExpandedHeight / kScrollCoefficient)) {
        return kBasePadding;
      }
      // In case 0% of the expanded height is viewed
      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        return (kExpandedHeight / kScrollCoefficient - kToolbarHeight) *
                kMultiplier +
            kBasePadding;
      }
      // In case 0%-50% of the expanded height is viewed
      return (_scrollController.offset -
                  (kExpandedHeight / kScrollCoefficient)) *
              kMultiplier +
          kBasePadding;
    }
    return kBasePadding;
  }
}
