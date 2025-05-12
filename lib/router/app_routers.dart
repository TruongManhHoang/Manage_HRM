import 'package:admin_hrm/common/widgets/layouts/sidebars/custom_sidebar.dart';
import 'package:admin_hrm/pages/comment_manager/comment_manager_page.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/employee/employee_page.dart';
import 'package:admin_hrm/pages/auth/bloc/auth_bloc.dart';
import 'package:admin_hrm/pages/auth/forget_password/forget_password.dart';
import 'package:admin_hrm/pages/auth/login/login_page.dart';
import 'package:admin_hrm/pages/auth/register/register_page.dart';
import 'package:admin_hrm/pages/comment_manager/comment_manager_page.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/school_page/school_page.dart';

import 'package:admin_hrm/router/router_observer.dart';
import 'package:admin_hrm/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../pages/dash_board/bloc/dash_board_bloc.dart';
import '../pages/dash_board/dash_board.dart';

import 'routers_name.dart';

class AppRouter {
  static final AppRouteObserver routeObserver = AppRouteObserver();

  static final GoRouter router = GoRouter(
      initialLocation: RouterName.login,
      // initialLocation: RouterName.dashboard,
      routes: [
        ShellRoute(
            builder: (context, state, child) {
              final authService = AuthService();
              return BlocProvider(
                create: (context) => AuthBloc(authService),
                child: Scaffold(
                  body: child,
                ),
              );
            },
            routes: [
              GoRoute(
                path: RouterName.login,
                name: RouterName.login,
                builder: (context, state) {
                  return const LoginPage();
                },
              ),
              GoRoute(
                path: RouterName.forgotPassword,
                name: RouterName.forgotPassword,
                builder: (context, state) {
                  return const ForgetPasswordPage();
                },
              ),
              GoRoute(
                path: RouterName.register,
                name: RouterName.register,
                builder: (context, state) {
                  return const RegisterPage();
                },
              )
            ]),
        GoRoute(
          path: RouterName.schoolPage,
          name: RouterName.schoolPage,
          builder: (context, state) {
            return const SchoolPage();
          },
        ),
        GoRoute(
          path: RouterName.commentManager,
          name: RouterName.commentManager,
          builder: (context, state) {
            return const CommentManagerPage();
          },
        ),
        GoRoute(
          path: RouterName.dashboard,
          name: RouterName.dashboard,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => DashboardBloc(),
              child: const DashBoardPage(),
            );
          },
        ),
        GoRoute(
          path: RouterName.departmentPage,
          name: RouterName.departmentPage,
          builder: (context, state) {
            return const DepartmentPage();
          },
        ),
        GoRoute(
          path: RouterName.employeePage,
          name: RouterName.employeePage,
          builder: (context, state) {
            return const EmployeePage();
          },
        ),
      ],

      // Định nghĩa redirection logic:
      // redirect: (BuildContext context, GoRouterState state) {
      //   final sidebarBloc = BlocProvider.of<SideBarBloc>(context);
      //   final routeName = state.name;
      //
      //   if (routeName != null && sidebarBloc.state.activeItem != routeName) {
      //     sidebarBloc.add(ChangeActiveItemEvent(route: routeName));
      //   }
      //   return null;
      // },
      observers: [
        routeObserver
      ]);
}
