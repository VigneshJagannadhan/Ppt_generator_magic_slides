import 'package:indian_app_guy/shared/providers/theme_provider.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/core/services/supabase_service.dart';
import 'package:indian_app_guy/features/Auth/presentation/providers/auth_provider.dart';
import 'package:indian_app_guy/features/Home/domain/repositories/home_repository.dart';
import 'package:indian_app_guy/features/Home/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get appProviders => [
  ChangeNotifierProvider(
    create:
        (context) => AuthProvider(
          supabaseService: locator<SupabaseService>(),
          storageService: locator<StorageService>(),
        ),
  ),

  ChangeNotifierProvider(
    create:
        (context) => HomeProvider(homeRepository: locator<HomeRepository>()),
  ),

  ChangeNotifierProvider(create: (context) => ThemeProvider()),
];
