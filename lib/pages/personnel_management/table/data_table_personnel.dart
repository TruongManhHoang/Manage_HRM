import 'package:admin_hrm/pages/dash_board/table/table_source.dart';
import 'package:admin_hrm/pages/personnel_management/table/table_personnel.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../constants/sizes.dart';

class DataTableEmployee extends StatelessWidget {
  const DataTableEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 500,
        dataRowHeight: TSizes.xl * 1.2,
        columns: const [
          DataColumn2(label: Text('Mã nhân viên')),
          DataColumn2(label: Text('Họ tên')),
          DataColumn2(label: Text('Giới tính')),
          DataColumn2(label: Text('Số điện thoại')),
          DataColumn2(label: Text('Chức vụ')),
          DataColumn2(label: Text('Ngày bắt đầu')),
          DataColumn2(label: Text('Trạng thái')),
          DataColumn2(label: Text('Chức năng khác')),
        ],
        source: TableEmployeeRows(context));
  }
}
