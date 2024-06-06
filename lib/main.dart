import 'package:e_mandi/bloc/bloc/login_bloc.dart';
import 'package:e_mandi/data/firebase/firebase_auth_repository.dart';
import 'package:e_mandi/domain/repositories/auth_repository.dart';
import 'package:e_mandi/firebase_options.dart';
import 'package:e_mandi/presentation/auth/login_screen.dart';
import 'package:e_mandi/presentation/billing/billing_screen.dart';
import 'package:e_mandi/presentation/category/category_screen.dart';
import 'package:e_mandi/presentation/initial/initial_screen.dart';
import 'package:e_mandi/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:e_mandi/localization/bloc/localization_bloc.dart';
import 'package:e_mandi/localization/bloc/localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'presentation/onboarding/onboarding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          create: (_) =>
              LoginBloc(firebaseAuthRepository: FirebaseAuthRepository()),
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
                home: Onboarding(),
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
  // getIt.registerLazySingleton<MoviesApiRepository>(() => MoviesHttpApiRepository()); // Registering MoviesHttpApiRepository as a lazy singleton for MoviesApiRepository
}
