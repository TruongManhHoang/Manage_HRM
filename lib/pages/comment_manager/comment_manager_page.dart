import 'package:admin_hrm/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin_hrm/pages/comment_manager/resposive_page/comment_manager_desktop.dart';
import 'package:admin_hrm/pages/comment_manager/resposive_page/comment_manager_mobile.dart';
import 'package:admin_hrm/pages/comment_manager/resposive_page/comment_manager_tablet.dart';
import 'package:flutter/material.dart';

class CommentManagerPage extends StatelessWidget {
  const CommentManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: CommentManagerDesktop(),
      mobile: CommentManagerMobile(),
      tablet: CommentManagerTablet(),
    );
    ;
  }
}
