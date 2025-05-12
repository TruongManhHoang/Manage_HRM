import 'package:admin_hrm/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/pages/comment_manager/table/comment_row.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CommentTable extends StatelessWidget {
  const CommentTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: TSizes.xl * 1.2,
      columns: const [
        DataColumn2(label: Text('Comment Id')),
        DataColumn2(label: Text('Content')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Created At')),
        DataColumn2(label: Text('Updated At')),
        DataColumn2(label: Text('User Id')),
        DataColumn2(label: Text('Blog Id')),
      ],
      source: CommentRows(context),
    );
  }
}
