import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelance_dxb/config/responsive.dart';
import 'package:freelance_dxb/config/size_config.dart';
import 'package:freelance_dxb/style/style.dart';

import '../categories/category_home.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: Container(
        height: SizeConfig.screenHeight,
        color: AppColors.secondaryBg,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Responsive.isDesktop(context)
                  ? Container(
                      height: 100,
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: SvgPicture.asset('assets/mac-action.svg'),
                      ),
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              IconButton(
                color: Color.fromARGB(255, 240, 67, 67),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CategoryHome()));
                },
                icon: SvgPicture.asset("assets/images/home.svg"),
                iconSize: 20,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              IconButton(
                color: Color.fromARGB(255, 240, 67, 67),
                onPressed: () {},
                icon: SvgPicture.asset('assets/images/pie-chart.svg'),
                iconSize: 20,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              IconButton(
                color: Color.fromARGB(255, 240, 67, 67),
                onPressed: () {},
                icon: SvgPicture.asset('assets/images/clipboard.svg'),
                iconSize: 20,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
