// import 'package:e_mandi/data/firebase/firebase_users_repository.dart';
// import 'package:e_mandi/data/insecure_local_storage_repository.dart';
// import 'package:e_mandi/domain/repositories/auth_repository.dart';
// import 'package:e_mandi/domain/repositories/local_storage_repository.dart';
// import 'package:e_mandi/domain/repositories/users_repository.dart';
// import 'package:e_mandi/firebase_options.dart'; // import localization provider
// import 'package:e_mandi/localization/controller.dart';
// import 'package:e_mandi/navigation/app_navigator.dart';
// import 'package:e_mandi/network/network_repository.dart';
// import 'package:e_mandi/presentation/auth/login_screen.dart';
// import 'package:e_mandi/theme/theme_data.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 
// import 'package:e_mandi/utils/routes/routes.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_it/get_it.dart'; // Localization support
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart'; // Import provider
// import 'data/firebase/firebase_auth_repository.dart';
// import 'presentation/onboarding/onboarding.dart';


// // GetIt is a package used for service locator or to manage dependency injection
// GetIt getIt = GetIt.instance;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//     servicesLocator(); // Initializing service locator for dependency injection


//   runApp(
//     const MyApp(),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(360, 690),
//       builder: (context, child) {
//         return ChangeNotifierProvider(
//           create: (_) => LocalizationProvider(),
//           child: Consumer<LocalizationProvider>(
//             builder: (context, localizationProvider, child) {
//               return MaterialApp(
//                 title: 'Flutter Demo',
//                 debugShowCheckedModeBanner: false,
//                 localizationsDelegates: const [
//                   AppLocalizations.delegate,
//                   GlobalMaterialLocalizations.delegate,
//                   GlobalWidgetsLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                 ],
//                 supportedLocales: const [
//                   Locale('en'), // English locale
//                   Locale('ur'), // Urdu locale
//                 ],
//                 locale: localizationProvider.locale,
//                 theme: ThemeData.light(),
//                 home: Onboarding(),
//                 onGenerateRoute: Routes.onGenerateRoute,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// void servicesLocator() {
//   getIt.registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository()); // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository
//   // getIt.registerLazySingleton<MoviesApiRepository>(() => MoviesHttpApiRepository()); // Registering MoviesHttpApiRepository as a lazy singleton for MoviesApiRepository
// }

import 'package:e_mandi/localization/bloc/localization_bloc.dart';
import 'package:e_mandi/localization/bloc/localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/onboarding/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalizationBloc(),
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            supportedLocales: [Locale('en'), Locale('ur')], // Add your supported locales here
            localizationsDelegates: [
              // Add your localization delegates here
            ],
            home: Onboarding(),
          );
        },
      ),
    );
  }
}
