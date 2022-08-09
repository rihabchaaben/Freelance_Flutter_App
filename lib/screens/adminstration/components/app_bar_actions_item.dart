import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_cubit.dart';
import 'package:freelance_dxb/screens/logIn/log_in.dart';
import 'package:freelance_dxb/style/style.dart';

class AppBarActionItem extends StatelessWidget {
  const AppBarActionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/images/calendar.svg',
            width: 20.0,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/images/ring.svg',
            width: 20.0,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(
                  'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859'),
            ),
            MaterialButton(
              onPressed: () {
                LogInCubit().signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        )
      ],
    );
  }
}
