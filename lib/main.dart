import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freelance_dxb/classifier.dart';
import 'cubit/freelancers_reviews/cubit/freelancers_reviews_cubit.dart';
import 'cubit/rate/cubit/rate_review_cubit.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_cubit.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_states.dart';
import 'package:freelance_dxb/cubit/offer/offer_cubit.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_cubit.dart';
import 'package:freelance_dxb/repositories/marketplace_repository.dart';
import 'package:freelance_dxb/screens/adminstration/dashboard.dart';
import 'package:freelance_dxb/screens/layout/home_layout.dart';
import 'package:freelance_dxb/screens/layout/home_layout_customer.dart';
import 'package:freelance_dxb/screens/opening_screen.dart';
import 'package:freelance_dxb/shared/bloc_observer.dart';
import 'package:freelance_dxb/shared/network/local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'cubit/customer/cubit/customer_profile_cubit.dart';
import 'cubit/marketplace/cubit/manage_marketplace_cubit.dart';
import 'models/erole.dart';

/// Message route arguments.
class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication);
}

bool isFlutterLocalNotificationsInitialized = false;

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    showBadge: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          number: 1,
          channelShowBadge: true,
          channelDescription: channel.description,

          //      one that already exists in example app.
          icon: 'launcher_icon',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    name: "webAppFreelance",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const FirebaseOptions(
      apiKey: "AIzaSyAW6H9aBwq6NQDVvtX1eRlI1qZpDzz8Y3w",
      authDomain: "freelancedxb-f9487.firebaseapp.com",
      projectId: "freelancedxb-f9487",
      storageBucket: "gs://freelancedxb-f9487.appspot.com/",
      messagingSenderId: "102625130392",
      appId: "1:102625130392:android:583f794cb357b32c425ded");

  Bloc.observer = MyBlocObserver();

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final classifier = Classifier();
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => OfferCubit()),
        BlocProvider(create: (context) => HomeCubit(context.read())),
        BlocProvider(
            create: (context) =>
                ManageMarketplaceCubit(MarketplaceRepository())),
        BlocProvider(create: (context) => CustomerProfileCubit(context.read())),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => RateReviewCubit(LogInCubit())),
        BlocProvider(create: (context) => FreelancersReviewsCubit()),
       //  BlocProvider(create: (context) => AddCategoryCubit()),
        
      ],
      child: MaterialApp(
        builder: (context, child) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: classifier,
            ),
          ],
          child: ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<LogInCubit, LogInStates>(listener: (context, state) {
          if (state is LogInSuccessState) {
            if (state.role == ERole.admin) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            } else if (state.role == ERole.freelancer) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeLayout()));
            } else if (state.role == ERole.customer) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeLayoutCustomer()));
            }
          }
          if (state is LogInErrorState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return OpeningScreen();
            }));
          }
        }, builder: (context, state) {
          LogInCubit.get(context).loginInit();
          return Text("");
        }),
        theme: ThemeData(primarySwatch: Colors.grey),
      ),
    );
  }
}
