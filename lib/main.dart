import 'package:stc_health/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        title: 'STC HEALTH',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
              headlineLarge: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: ScreenHelper.screenHeight(context) * 0.036),
              headlineMedium: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: ScreenHelper.screenHeight(context) * 0.034),
              bodyLarge: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: ScreenHelper.screenHeight(context) * 0.026),
              bodyMedium: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: ScreenHelper.screenHeight(context) * 0.016),
              bodySmall: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: ScreenHelper.screenHeight(context) * 0.014)),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
