import 'package:code_shopping/models/parking.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class Tile extends StatelessWidget {
  final Parking parking;
  final VoidCallback onDelete;

  const Tile({
    Key? key,
    required this.parking,
    required this.onDelete
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
        title: Text(
          parking.number ?? "",
          style:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (parking.status?.isNotEmpty != null)
              Text(
                "  status: ${parking.status}",
                style: const TextStyle(color: Colors.grey),
              ),
            Text(
              "  address : ${parking.address}",
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "  id : ${parking.id}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // onTap: () => showDialog(
        //     context: context,
        //     builder: (context) => Center(
        //       child: Stack(children: [
        //         SingleChildScrollView(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Flexible(
        //                       child: Image.asset('assets/images/img.png')),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Material(
        //               color: Colors.black.withOpacity(0.5),
        //               child: IconButton(
        //                 onPressed: () => Navigator.of(context).pop(),
        //                 icon: const Icon(
        //                   Icons.close,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         )
        //       ]),
        //     )),
      ),
    );
  }
}
