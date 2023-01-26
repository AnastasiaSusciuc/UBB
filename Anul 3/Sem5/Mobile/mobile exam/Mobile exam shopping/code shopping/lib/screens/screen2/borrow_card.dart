import 'package:flutter/material.dart';

import '../../models/parking.dart';
import '../../theme/app_colors.dart';

class BorrowListTile extends StatelessWidget {
  final Parking book;
  final VoidCallback onClick;

  const BorrowListTile({
    Key? key,
    required this.book,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        minVerticalPadding: 7,
        dense: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: AppColors.primaryColor.withOpacity(0.25),
        // leading: ClipRRect(
        //   borderRadius: const BorderRadius.all(Radius.circular(15)),
        //   child: SizedBox(
        //     height: 50,
        //     width: 50,
        //     child: FittedBox(
        //       fit: BoxFit.cover,
        //       child: Image.asset('assets/images/img.jpeg'),
        //     ),
        //   ),
        // ),
        title: Text(
          book.number ?? "",
          style:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.status?.isNotEmpty != null)
              Text(
                "  status: ${book.status}",
                style: const TextStyle(color: Colors.grey),
              ),
            Text(
              "  count: ${book.count.toString()}",
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "  address: ${book.address.toString()}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onClick,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
        onTap: () => showDialog(
            context: context,
            builder: (context) => Center(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Image.asset('assets/images/img.png')),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.black.withOpacity(0.5),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
