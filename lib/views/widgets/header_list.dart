import 'package:flutter/material.dart';

class HeaderList extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String subTitle;

  const HeaderList({super.key, required this.title, required this.subTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(subTitle, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),),
            ],
          ),
          InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleMedium,
              )),
        ],
      ),
    );
  }
}