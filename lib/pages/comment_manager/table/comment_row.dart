import 'package:admin_hrm/common/widgets/containers/rounded_container.dart';
import 'package:admin_hrm/constants/colors.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/data/model/comment_model.dart';
import 'package:admin_hrm/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CommentRows extends DataTableSource {
  final BuildContext context;
  CommentRows(this.context);

  @override
  DataRow? getRow(int index) {
    final commnent = CommentData.comments[index];
    return DataRow2(cells: [
      // 1. Comment Id
      DataCell(Text(
        '${commnent.id}',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.primary),
      )),

      // 2. Content
      DataCell(Text(commnent.content)),

      // 3. Status (CHUYỂN VỊ TRÍ LÊN TRƯỚC)
      DataCell(TRoundedContainer(
        radius: TSizes.cardRadiusSm,
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.xs, horizontal: TSizes.md),
        backgroundColor: THelperFunctions.getCommentStatusColor(commnent.status)
            .withOpacity(0.1),
        child: Text(
          commnent.status.name.toString(),
          style: TextStyle(
              color: THelperFunctions.getCommentStatusColor(commnent.status)),
        ),
      )),

      // 4. Created At
      DataCell(Text(commnent.formattedCreateAt)),

      // 5. Updated At
      DataCell(Text(commnent.formattedUpdateAt)),

      // 6. User Id
      DataCell(Text('${commnent.user_id}')),

      // 7. Blog Id
      DataCell(Text('${commnent.blog_id}')),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => CommentData.comments.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
