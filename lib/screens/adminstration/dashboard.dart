import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_dxb/config/responsive.dart';
import 'package:freelance_dxb/config/size_config.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:freelance_dxb/style/style.dart';

import 'components/components.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  });
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(
        width: 100,
        child: SideMenu(),
      ),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(255, 247, 7, 7),
                  )),
              actions: const [AppBarActionItem()],
            )
          : const PreferredSize(
              child: SizedBox(),
              preferredSize: Size.zero,
            ),
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              flex: 1,
              child: SideMenu(),
            ),
          Expanded(
            flex: 10,
            child: SizedBox(
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.all(Responsive.isDesktop(context) ? 30 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardHeader(),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? SizeConfig.blockSizeVertical! * 5
                          : SizeConfig.blockSizeVertical! * 3,
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      child: Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        alignment: WrapAlignment.spaceBetween,
                        children: const [
                          InfoCard(
                            icon: 'assets/images/credit-card.svg',
                            label: 'Transfer via\nCard number',
                            amount: '\$1200',
                          ),
                          InfoCard(
                            icon: 'assets/images/transfer.svg',
                            label: 'Transfer via\nOnline banks',
                            amount: '\$2000',
                          ),
                          InfoCard(
                            icon: 'assets/images/bank.svg',
                            label: 'Transfer via\nSame bank',
                            amount: '\$1500',
                          ),
                          InfoCard(
                            icon: 'assets/images/invoice.svg',
                            label: 'Transfer to\nOther bank',
                            amount: '\$800',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? SizeConfig.blockSizeVertical! * 4
                          : SizeConfig.blockSizeVertical! * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 3,
                    ),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? SizeConfig.blockSizeVertical! * 5
                          : SizeConfig.blockSizeVertical! * 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 4,
              child: Column(
                children: const [
                  AppBarActionItem(),
                ],
              ),
            ),
        ]),
      ),
    );
  }
}
