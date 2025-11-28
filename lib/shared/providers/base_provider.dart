import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Failure? _errorMessage;
  Failure? get error => _errorMessage;
  setError(Failure? value) {
    _errorMessage = value;
  }

  reset();
}
