import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_cubit.dart';
import 'package:freelance_dxb/repositories/marketplace_repository.dart';
import 'package:freelance_dxb/screens/opening_screen.dart';
import 'package:freelance_dxb/shared/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freelance_dxb/shared/network/local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/customer/cubit/customer_profile_cubit.dart';
import 'cubit/marketplace/cubit/manage_marketplace_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  options:
  const FirebaseOptions(
      apiKey: "AIzaSyAW6H9aBwq6NQDVvtX1eRlI1qZpDzz8Y3w",
      authDomain: "freelancedxb-f9487.firebaseapp.com",
      projectId: "freelancedxb-f9487",
      storageBucket: "gs://freelancedxb-f9487.appspot.com/",
      messagingSenderId: "102625130392",
      appId: "1:102625130392:android:583f794cb357b32c425ded");

  Bloc.observer = MyBlocObserver();
  bool chooseFirstPagse = CacheHelper.getDate(key: "isSigned") == null
      ? false
      : CacheHelper.getDate(key: "isSigned");
  print(chooseFirstPagse);
  runApp(MyApp(chooseFirstPagse));
}

class MyApp extends StatelessWidget {
  bool whoIsFirst;
  MyApp(this.whoIsFirst);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(
              create: (context) =>
                  ManageMarketplaceCubit(MarketplaceRepository())),
          BlocProvider(create: (context) => CustomerProfileCubit()),
          BlocProvider(create: (context) => SignUpCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: OpeningScreen(),
          theme: ThemeData(primarySwatch: Colors.grey),
        ));
  }
}
