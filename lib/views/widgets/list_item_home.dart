import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';

class ListItemHome extends StatelessWidget {
  final Product product;

  const ListItemHome({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                product.imgUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 50.0,
                height: 25.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      '${product.discountValue} %',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            product.category,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 6.0),
          Text(
            product.title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            '${product.price}\$',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
