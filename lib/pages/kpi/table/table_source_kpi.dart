import 'package:admin_hrm/data/model/kpi/kpi_model.dart';
import 'package:admin_hrm/pages/department/bloc/department_bloc.dart';
import 'package:admin_hrm/pages/department/bloc/department_event.dart';
import 'package:admin_hrm/pages/kpi/bloc/kpi_bloc.dart';
import 'package:admin_hrm/pages/kpi/bloc/kpi_event.dart';

import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';

class KPITableRows extends DataTableSource {
  final BuildContext context;
  final List<KPIModel> kpis;

  KPITableRows(this.context, this.kpis);

  @override
  DataRow? getRow(int index) {
    final kpi = kpis[index];

    TextStyle baseStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: TColors.dark, fontSize: 12);

    TextStyle highlightStyle = baseStyle.copyWith(
      color: TColors.primary,
      fontWeight: FontWeight.w600,
    );

    return DataRow2(cells: [
      DataCell(Center(
          child: Text(
        kpi.userId,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.textPrimary),
      ))),
      DataCell(Center(
          child: Text(
        kpi.departmentId,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.textPrimary),
      ))),
      DataCell(Center(
          child: Text(
        kpi.period,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.textPrimary),
      ))),
      DataCell(Center(
          child: Text(
        kpi.totalScore.toString(),
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.textPrimary),
      ))),
      DataCell(Center(
          child: Text(
        kpi.evaluatorId ?? '-',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.textPrimary),
      ))),
      DataCell(Center(
          child: Text(
        kpi.notes ?? '-',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.textPrimary),
      ))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => kpis.length;

  @override
  int get selectedRowCount => 0;

  void _confirmDelete(BuildContext context, KPIModel kpi) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xoá'),
        content:
            Text('Bạn có chắc chắn muốn xoá kpi của "${kpi.userId}" không?'),
        actions: [
          TextButton(
            child: const Text('Huỷ'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text('Xoá', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<KPIBloc>().add(DeleteKPI(kpi.id));
            },
          ),
        ],
      ),
    );
  }
}
