import 'package:flutter/material.dart';

import '../Screens/cart/cart.dart';

class CartProvider extends ChangeNotifier {
  Cart _cart = Cart();
  double _userBudget = 0.0;
  double _totalSpent = 0.0; // This is a getter

  Cart get cart => _cart;
  double get userBudget => _userBudget;
  double get totalSpent => _totalSpent;

  void setUserBudget(double budget) {
    _userBudget = budget;
    notifyListeners();
  }

  // Add a setter for totalSpent
  set totalSpent(double value) {
    _totalSpent = value;
    notifyListeners();
  }
}

