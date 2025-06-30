import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'data/repositories/portfolio_repository.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();
  final PortfolioRepository _portfolioRepository = PortfolioRepository();

  @override
  void dispose() {
    _portfolioRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // Desktop-first design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>.value(value: _themeProvider),
            ChangeNotifierProvider<PortfolioRepository>.value(
                value: _portfolioRepository),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Netanel Klein - Personal Homepage',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.themeMode,
                home: Scaffold(
                  body: Column(
                    children: [
                      // Debug button to force refresh
                      Container(
                        color: Colors.red,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print('🔄 Force refresh button pressed');
                                _portfolioRepository.refresh();
                              },
                              child: const Text('Force API Refresh'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                print('🗑️ Clear cache button pressed');
                                _portfolioRepository.clearCache();
                              },
                              child: const Text('Clear Cache'),
                            ),
                            const SizedBox(width: 10),
                            Consumer<PortfolioRepository>(
                              builder: (context, repo, child) {
                                return Text(
                                  'State: ${repo.loadingState} | Has Data: ${repo.hasData}',
                                  style: const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Regular home page
                      const Expanded(child: HomePage()),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
