import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/data/models/carts.dart';
import 'package:testing_app/data/repository/cart_provider.dart';

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CartProvider>(context, listen: false).fetchCartID(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          // If the cart is still loading, show a loading indicator
          if (cartProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            );
          }

          // If there was an error fetching the cart
          if (cartProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    cartProvider.error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Retry fetching the cart
                      cartProvider.fetchCartID(widget.id);
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // If no cart data is found
          if (cartProvider.cart == null) {
            return Center(child: Text("No cart found!"));
          }

          // Cart data is available
          Carts cart = cartProvider.cart!;

          return ListView(
            padding: EdgeInsets.all(12),
            children: cart.products.map(
              (product) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 5,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white30),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white24),
                            child: Image.network(
                              product.thumbnail,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.lightBlue,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Price: \$${product.price.toStringAsFixed(2)} | Qty: ${product.quantity}"),
                              SizedBox(height: 4),
                              Text(
                                "Total: \$${product.total.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Discount: ${product.discountPercentage.toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.redAccent),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Discounted Total: \$${product.discountedTotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
