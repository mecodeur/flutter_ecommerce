import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/assets.dart';
import 'package:flutter_ecommerce/views/widgets/header_of_list.dart';
import 'package:flutter_ecommerce/views/widgets/list_item_home.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageAsset,
                width: double.infinity,
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.2,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                HeaderOfList(
                  title: 'Sale',
                  subTitle: 'Super Summer Sale!!',
                  onTap: () {},
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.newProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            const Center(child: Text('No Data Available!'));
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListItemHome(
                                  product: products[index],
                                  isNew: true,
                                );
                              },
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
                const SizedBox(height: 16.0),
                HeaderOfList(
                  onTap: () {},
                  title: 'New',
                  subTitle: "You've never seen it before!",
                ),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.salesProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            const Center(child: Text('No data available !!'));
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListItemHome(
                                  product: products[index],
                                  isNew: true,
                                );
                              },
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
