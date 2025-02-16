import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/constants/color_constants.dart';
import 'src/core/constants/string_constants.dart';
import 'src/core/routing/routing_config.dart';
import 'src/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'src/features/subscription/presentation/bloc/subscription_event.dart';

void mainDelegate() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// System Orientation
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    /// BotToast Initialize
    final botToastBuilder = BotToastInit();
    return MaterialApp.router(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: ColorConstants.black,
      ),
      routerConfig: RoutingConfig.router,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SubscriptionBloc()..add(LoadSubscriptions())),
          ],
          child: child,
        );
      },
    );
  }
}
