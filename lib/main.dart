import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/core/constants/color_constants.dart';
import 'src/core/constants/string_constants.dart';
import 'src/core/routing/routing_config.dart';
import 'src/features/splash/presentation/bloc/splash_bloc.dart';
import 'src/features/subscription/data/subscription_model.dart';
import 'src/features/subscription/presentation/bloc/subscription_bloc.dart';

Future<void> mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeHive();
  final subscriptionBloc = SubscriptionBloc()..initializeHive();
  runApp(
    MyApp(
      subscriptionBloc: subscriptionBloc,
    ),
  );
}

Future<void> _initializeHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(SubscriptionModelAdapter())
    ..registerAdapter(SubModelAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.subscriptionBloc,
  });

  final SubscriptionBloc subscriptionBloc;

  @override
  Widget build(BuildContext context) {
    _setPreferredOrientations();

    final botToastBuilder = BotToastInit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc(subscriptionBloc: subscriptionBloc)),
        BlocProvider.value(value: subscriptionBloc),
      ],
      child: MaterialApp.router(
        title: StringConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: ColorConstants.black,
        ),
        routerConfig: RoutingConfiguration.router,
        builder: (context, child) => botToastBuilder(context, child),
      ),
    );
  }

  void _setPreferredOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
