import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/data/model/attendance/attendance_model.dart';
import 'package:admin_hrm/pages/attendance/bloc/attendance_bloc.dart';
import 'package:admin_hrm/pages/attendance/bloc/attendance_event.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../constants/colors.dart';

class AttendanceTableRows extends DataTableSource {
  final BuildContext context;
  final List<AttendanceModel> attendances;

  AttendanceTableRows(this.context, this.attendances);

  final dateFormatter = DateFormat('dd/MM/yyyy');
  final timeFormatter = DateFormat('HH:mm');

  @override
  DataRow? getRow(int index) {
    if (index >= attendances.length) return null;

    final attendance = attendances[index];

    TextStyle baseStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: TColors.dark, fontSize: 12);

    return DataRow2(
      cells: [
        DataCell(Center(child: Text(attendance.userId, style: baseStyle))),
        DataCell(Center(
            child:
                Text(dateFormatter.format(attendance.date), style: baseStyle))),
        DataCell(Center(
            child: Text(
          attendance.checkInTime != null
              ? timeFormatter.format(attendance.checkInTime!)
              : '-',
          style: baseStyle,
        ))),
        DataCell(Center(
            child: Text(
          attendance.checkOutTime != null
              ? timeFormatter.format(attendance.checkOutTime!)
              : '-',
          style: baseStyle,
        ))),
        DataCell(Center(
            child: Text(attendance.workLocation ?? '-', style: baseStyle))),
        DataCell(
            Center(child: Text(attendance.notes ?? '-', style: baseStyle))),
        DataCell(Center(
          child: Icon(
            attendance.isLate
                ? Icons.warning_amber_rounded
                : Icons.check_circle,
            color: attendance.isLate ? Colors.orange : Colors.green,
            size: 18,
          ),
        )),
        DataCell(Center(
          child: Icon(
            attendance.isAbsent ? Icons.close_rounded : Icons.check_circle,
            color: attendance.isAbsent ? Colors.red : Colors.green,
            size: 18,
          ),
        )),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.pushNamed(
                  RouterName.editAttendance,
                  extra: attendance,
                );
              },
              icon: const Icon(Icons.edit),
              color: TColors.primary,
            ),
            const SizedBox(width: TSizes.xs),
            IconButton(
              onPressed: () {
                _confirmDelete(context, attendance);
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => attendances.length;

  @override
  int get selectedRowCount => 0;

  void _confirmDelete(BuildContext context, AttendanceModel attendance) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xoá'),
        content: Text(
            'Bạn có chắc chắn muốn xoá bản ghi ngày "${DateFormat('dd/MM/yyyy').format(attendance.date)}"?'),
        actions: [
          TextButton(
            child: const Text('Huỷ'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text('Xoá', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(ctx).pop();
              context
                  .read<AttendanceBloc>()
                  .add(DeleteAttendance(attendance.id, attendance.userId));
            },
          ),
        ],
      ),
    );
  }
}
