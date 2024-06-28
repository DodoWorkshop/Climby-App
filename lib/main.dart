import 'package:climby/theme/app_theme.dart';
import 'package:climby/widget/layout/authentication_controller.dart';
import 'package:climby/widget/layout/base_providers_builder.dart';
import 'package:climby/widget/layout/main_layout.dart';
import 'package:climby/widget/layout/notification_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await dotenv.load();
  await initializeDateFormatting('fr_FR', null);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climby',
      theme: appTheme,
      home: const BaseProvidersBuilder(
        child: NotificationWrapper(
          child: AuthenticationController(
            child: MainLayout(),
          ),
        ),
      ),
    );
  }
}
