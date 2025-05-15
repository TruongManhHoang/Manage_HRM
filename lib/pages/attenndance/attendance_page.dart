import 'package:flutter/material.dart';

import '../../common/widgets/layouts/templates/site_layout.dart';
import 'resposive_page/attendance_page_desktop.dart';
import 'resposive_page/attendance_page_mobile.dart';
import 'resposive_page/attendance_page_table.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: AttendancePageDesktop(),
      tablet: AttendancePageTable(),
      mobile: AttendancePageMobile(),
    );
  }
}
