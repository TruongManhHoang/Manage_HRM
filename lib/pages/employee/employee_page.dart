import 'package:admin_hrm/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin_hrm/pages/dash_board/bloc/dash_board_bloc.dart';
import 'package:admin_hrm/pages/department/resposive_page/department_page_desktop.dart';
import 'package:admin_hrm/pages/department/resposive_page/department_page_mobile.dart';
import 'package:admin_hrm/pages/department/resposive_page/department_page_table.dart';
import 'package:admin_hrm/pages/employee/resposive_page/employee_page_desktop.dart';
import 'package:admin_hrm/pages/employee/resposive_page/employee_page_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: EmployeePageDesktop(),
      tablet: EmployeePageTablet(),
      mobile: DepartmentPageMobile(),
    );
  }
}
