import 'package:admin_hrm/pages/school_page/resposive_page/school_desktop.dart';
import 'package:admin_hrm/pages/school_page/resposive_page/school_mobile.dart';
import 'package:admin_hrm/pages/school_page/resposive_page/school_table.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/layouts/templates/site_layout.dart';

class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: SchoolDesktopPage(),
      mobile: SchoolMobilePage(),
      tablet: SchoolTablePage(),
    );
  }
}
