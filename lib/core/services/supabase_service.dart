import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  /// SERVICE CLASS FOR SUPABASE

  late Supabase _supabase;

  /// INITIALIZE SUPABASE
  Future initialize() async {
    String url = dotenv.env['SUPABASE_URL'] ?? "";
    String anonKey = dotenv.env['ANON_KEY'] ?? "";
    await Supabase.initialize(url: url, anonKey: anonKey);
    _supabase = Supabase.instance;
  }

  Future<Either<Failure, AuthResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse authResponse = await _supabase.client.auth
          .signInWithPassword(email: email, password: password);
      return Right(authResponse);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuthResponse>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> data,
  }) async {
    try {
      AuthResponse authResponse = await _supabase.client.auth.signUp(
        email: email,
        data: data,
        password: password,
      );
      return Right(authResponse);
    } catch (e) {
      throw Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> signOut() async {
    try {
      await _supabase.client.auth.signOut();
      return Right(true);
    } catch (e) {
      throw Left(Failure(message: e.toString()));
    }
  }
}
