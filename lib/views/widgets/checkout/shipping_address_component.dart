import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../utilities/routes.dart';

class ShippingAddressComponent extends StatelessWidget {
  final ShippingAddress shippingAdress;
  const ShippingAddressComponent({Key? key, required this.shippingAdress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAdress.fullName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.shippingAddressesRoute,
                    arguments: database,
                  ),
                  child: Text(
                    'Change',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              shippingAdress.address,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${shippingAdress.city}, ${shippingAdress.state}, ${shippingAdress.country}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
