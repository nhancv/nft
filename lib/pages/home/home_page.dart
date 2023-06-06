import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app/app_route.dart';
import 'package:nft/services/providers/providers.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/widgets/p_appbar_empty.dart';
import 'package:nft/widgets/w_keyboard_dismiss.dart';

final pHomeProvider = ChangeNotifierProvider((ref) => HomeProvider(ref.watch(pApiUserProvider)));

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends PageStateful<HomePage> with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute<dynamic>? c = ModalRoute.of(context);
    if (c != null) {
      AppRoute.I.routeObserver.subscribe(this, c);
    }
  }

  @override
  void didPush() {
    /// Called when the current route has been pushed.
    logger.d('didPush');
  }

  @override
  void didPopNext() {
    /// Called when the top route has been popped off, and the current route
    /// shows up.
    logger.d('didPopNext');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppRoute.I.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Log app life cycle state
    logger.d(state);
  }

  @override
  Widget build(BuildContext context) {
    return PAppBarEmpty(
      child: WKeyboardDismiss(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.W),
                child: Text(context.strings.hello),
              ),

              /// As default, when user change language in device setting
              /// -> the locale will change appropriately
              /// This button provides user can change the locale manually
              TextButton(
                onPressed: () {
                  /// Get current locale
                  final Locale myLocale = Localizations.localeOf(context);
                  final String languageCode = myLocale.languageCode;

                  /// Change to new locale
                  if (languageCode == 'en') {
                    localeProvider.locale = const Locale('vi');
                  } else {
                    localeProvider.locale = const Locale('en');
                  }
                },
                child: const Text('Translate'),
              ),

              SizedBox(height: 10.H),

              /// Example to use selector instead consumer to optimize render performance
              /// https://docs-v2.riverpod.dev/docs/concepts/reading#obtaining-a-ref-object
              Text(
                ref.watch(pHomeProvider.select((value) => value.token?.toJson().toString() ?? '')),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10.H),

              /// Navigate to counter page with current timestamp as argument
              ElevatedButton(
                key: const Key(AppRoute.routeCounter),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.routeCounter, arguments: 'From Home ${DateTime.now()}');
                },
                child: const Text('Counter Page'),
              ),

              SizedBox(height: 10.H),

              /// Logout
              /// Navigate to login
              ElevatedButton(
                key: const Key(AppRoute.routeLogin),
                onPressed: () async {
                  logout(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
