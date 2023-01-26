import 'package:access/models/my_entity.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class Tile2 extends StatelessWidget {
  final MyEntity myEntity;

  const Tile2({
    Key? key,
    required this.myEntity,
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
          "RULE ${myEntity.name ?? ""}",
          style:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (myEntity.status?.isNotEmpty != null)
              Text(
                "  status: ${myEntity.status}",
                style: const TextStyle(color: Colors.grey),
              ),
            Text(
              "  level: ${myEntity.level.toString()}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        // onTap: () => showDialog(
        //     context: context,
        //     builder: (context) => Center(
        //           child: Stack(children: [
        //             SingleChildScrollView(
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Flexible(
        //                           child: Image.asset('assets/images/img.png')),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             // Row(
        //             //   mainAxisAlignment: MainAxisAlignment.end,
        //             //   children: [
        //             //     Material(
        //             //       color: Colors.black.withOpacity(0.5),
        //             //       child: IconButton(
        //             //         onPressed: () => Navigator.of(context).pop(),
        //             //         icon: const Icon(
        //             //           Icons.close,
        //             //           color: Colors.white,
        //             //         ),
        //             //       ),
        //             //     ),
        //             //   ],
        //             // )
        //           ]),
        //         )),
      ),
    );
  }
}
