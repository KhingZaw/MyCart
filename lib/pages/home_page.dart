import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/components/drawer_widget.dart';
import 'package:testing_app/data/repository/cart_provider.dart';
import 'package:testing_app/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).fetchCarts();
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit App?"),
        content: Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmed = await _showExitDialog(context) ?? false;
        return exitConfirmed;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text("Home", style: TextStyle(fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: cartProvider.isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.lightBlue))
            : cartProvider.error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: 50, color: Colors.red),
                        SizedBox(height: 10),
                        Text(cartProvider.error!,
                            style: TextStyle(color: Colors.red, fontSize: 16)),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => cartProvider.fetchCarts(),
                          child: Text("Retry"),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    color: Colors.lightBlue,
                    onRefresh: cartProvider.fetchCarts,
                    child: ListView.builder(
                      itemCount: cartProvider.carts.length,
                      itemBuilder: (context, index) {
                        var cart = cartProvider.carts[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: ExpansionTile(
                            title: Text('User ID: ${cart.userId}'),
                            subtitle:
                                Text("Total Products: ${cart.totalProducts}"),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Total Quantity: ${cart.totalQuantity}'),
                                        SizedBox(height: 4),
                                        Text(
                                            'Total: \$${cart.total.toStringAsFixed(2)}'),
                                        SizedBox(height: 4),
                                        Text(
                                            'Discounted Total: \$${cart.discountedTotal}'),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(id: cart.id),
                                          ),
                                        );
                                      },
                                      child: Text("Detail",
                                          style: TextStyle(
                                              color: Colors.lightBlue)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
