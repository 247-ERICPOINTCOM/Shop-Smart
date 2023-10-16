import 'package:shopsmartly/product.dart';

class CartService {
  final List<Product> _cart = [];

  List<Product> getCart() => _cart;

  void addToCart(Product product) {
    _cart.add(product);
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
  }

  double calculateTotal() {
    return _cart.map((product) => product.price).fold(0.0, (a, b) => a + b);
  }
}
