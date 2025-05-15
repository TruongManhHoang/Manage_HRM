import 'package:admin_hrm/pages/dash_board/table/table_source.dart';
import 'package:admin_hrm/pages/personnel_management/table/table_personnel.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../constants/sizes.dart';
import '../bloc/personnel_bloc.dart';
import '../bloc/personnel_state.dart';

class DataTableEmployee extends StatelessWidget {
  const DataTableEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonelCubit, AddEmployeeState>(
      listener: (context, state) {
        if (state is AddEmployeeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AddEmployeeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AddEmployeeFailure) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }

        if (state is GetEmployeeSuccess) {
          final employees = state.employees;

          if (employees.isEmpty) {
            return const Center(child: Text('Không có dữ liệu nhân viên.'));
          }

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
            source: TableEmployeeRows(context, employees),
          );
        }

        return const SizedBox(); 
      },
    );
  }
}
