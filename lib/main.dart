import 'package:aperture/utils/colors.dart';
import 'package:aperture/providers/login_form_provider.dart';
import 'package:aperture/providers/register_form_provider.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/providers/user_level_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); 

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    // Listen for Supabase auth events (passwordRecovery fires when
    // the user clicks the reset link and lands back in your app)
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.passwordRecovery) {
        _navigatorKey.currentState?.pushNamed(AppRouter.resetPasswordRoute);
      }
    });
  }

  //TODO: Add ThemeData to the app, and make it look nice
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserLevelProvider>(
          create: (_) => UserLevelProvider(),
        ),
        ChangeNotifierProvider<LoginFormProvider>(
          create: (_) => LoginFormProvider(),
        ),
        ChangeNotifierProvider<RegisterFormProvider>(
          create: (_) => RegisterFormProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
