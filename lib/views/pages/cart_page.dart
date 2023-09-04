import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
import 'package:provider/provider.dart';

import '../widgets/main_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount = 0;

  @override
  void didChangeDependencies() async{
    final myProducts = await Provider.of<Database>(context).myProductCart().first;
    myProducts.forEach((element) {
      setState(() {
        totalAmount += element.price;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
          stream: database.myProductCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final cartItems = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.search)),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'My Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      if (cartItems == null || cartItems.isEmpty)
                        Center(
                          child: Text(
                            'No Data Available!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (cartItems != null && cartItems.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cartItem = cartItems[index];
                            return CartListItem(
                              cartItem: cartItem,
                            );
                          },
                        ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                          Text(
                            '${totalAmount.toString().substring(0,5)}\$',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      MainButton(
                        text: 'Checkout',
                        onTap: () {},
                        hasCircularBorder: true,
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
