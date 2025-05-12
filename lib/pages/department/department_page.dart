import 'package:admin_hrm/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin_hrm/pages/dash_board/bloc/dash_board_bloc.dart';
import 'package:admin_hrm/pages/dash_board/resposive_page/dash_board_desktop.dart';
import 'package:admin_hrm/pages/dash_board/resposive_page/dash_board_mobile.dart';
import 'package:admin_hrm/pages/dash_board/resposive_page/dash_board_table.dart';
import 'package:admin_hrm/pages/department/resposive_page/department_page_desktop.dart';
import 'package:admin_hrm/pages/department/resposive_page/department_page_mobile.dart';
import 'package:admin_hrm/pages/department/resposive_page/department_page_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: DepartmentPageDesktop(),
      tablet: DepartmentPageTable(),
      mobile: DepartmentPageMobile(),
    );
  }
}
