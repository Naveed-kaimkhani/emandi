import 'package:e_mandi/bloc/billing_bloc/billing_bloc.dart';
import 'package:e_mandi/bloc/create_bill_bloc/create_bill_bloc.dart';
import 'package:e_mandi/bloc/login_bloc/login_bloc.dart';
import 'package:e_mandi/data/firebase/firebase_auth_repository.dart';
import 'package:e_mandi/domain/repositories/billing_repository.dart';
import 'package:e_mandi/domain/repositories/item_repository.dart';
import 'package:e_mandi/domain/repositories/ledger_repository.dart';
import 'package:e_mandi/domain/repositories/auth_repository.dart';
import 'package:e_mandi/data/hive/hive_billing_repository.dart';
import 'package:e_mandi/data/hive/hive_item_repository.dart';
import 'package:e_mandi/data/hive/hive_ledger_repository.dart';
import 'package:e_mandi/firebase_options.dart';
import 'package:e_mandi/presentation/category/category_screen.dart';
import 'package:e_mandi/presentation/initial/initial_screen.dart';
import 'package:e_mandi/presentation/splash/splash_screen.dart';
import 'package:e_mandi/services/splash/splash_services.dart';
import 'package:e_mandi/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:e_mandi/localization/bloc/localization_bloc.dart';
import 'package:e_mandi/localization/bloc/localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // // await Hive.openBox<Map>('billingBox');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  servicesLocator(); // Initializing service locator for dependency injection

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocalizationBloc(),
        ),
        BlocProvider(
          // create: (_) =>
          create: (_) => LoginBloc(authRepository: getIt()), // Updated line
        ),
        BlocProvider(
          create: (_) => ItemBloc(billingRepository: getIt()),
        ),
        BlocProvider(
          create: (_) => CreateBillBloc(billingRepository: getIt()),
        )
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375,
                812), // Set the design size (width, height) as per your design
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: state.locale,
                supportedLocales: const [Locale('en'), Locale('ur')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: SplashView(),
                onGenerateRoute: Routes.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

void servicesLocator() {
  getIt.registerLazySingleton<AuthRepository>(() =>
      FirebaseAuthRepository()); // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository

  getIt.registerLazySingleton<ItemRepository>(() => HiveItemRepository());
  getIt.registerLazySingleton<LedgerRepository>(() => HiveLedgerRepository());

  getIt.registerLazySingleton<BillingRepository>(() => HiveBillingRepository());
}
