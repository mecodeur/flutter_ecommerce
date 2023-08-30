import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleLarge,
        )),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.5,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.title}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${widget.product.price} \$ ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.product.category,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey)),
                  const SizedBox(height: 16.0),
                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                  style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  MainButton(text: 'Add to Cart',  onTap: (){}, hasCircularBorder: true,),
                  const SizedBox(height: 32.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}