import 'package:admin_hrm/pages/account/account_page.dart';
import 'package:admin_hrm/pages/account/add_account.dart';
import 'package:admin_hrm/pages/contract/contract_page.dart';
import 'package:admin_hrm/pages/contract/widgets/add_contract.dart';
import 'package:admin_hrm/pages/department/add_department_page.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/personnel_management/personnel_page.dart';
import 'package:admin_hrm/pages/personnel_management/widgets/add_personnel.dart';
import 'package:admin_hrm/pages/auth/bloc/auth_bloc.dart';
import 'package:admin_hrm/pages/auth/forget_password/forget_password.dart';
import 'package:admin_hrm/pages/auth/login/login_page.dart';
import 'package:admin_hrm/pages/auth/register/register_page.dart';
import 'package:admin_hrm/pages/position/position_page.dart';
import 'package:admin_hrm/pages/position/widgets/add_position.dart';

import 'package:admin_hrm/router/router_observer.dart';
import 'package:admin_hrm/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/model/personnel_management.dart';
import '../pages/attenndance/attendance_page.dart';
import '../pages/dash_board/bloc/dash_board_bloc.dart';
import '../pages/dash_board/dash_board.dart';

import '../pages/personnel_management/bloc/personnel_bloc.dart';
import '../pages/personnel_management/table/update_personnel.dart';
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
            return BlocProvider(
              create: (_) => PersonelCubit(),
              child: const EmployeePage(),
            );
          },
        ),
        GoRoute(
          path: RouterName.addEmployee,
          name: RouterName.addEmployee,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => PersonelCubit(),
              child: const AddEmployeeForm(),
            );
          },
        ),
        GoRoute(
          path: RouterName.contractPage,
          name: RouterName.contractPage,
          builder: (context, state) {
            return const ContractPage();
          },
        ),
        GoRoute(
          path: RouterName.addContract,
          name: RouterName.addContract,
          builder: (context, state) {
            return const AddContract();
          },
        ),
        GoRoute(
          path: RouterName.accountPage,
          name: RouterName.accountPage,
          builder: (context, state) {
            return const AccountPage();
          },
        ),
        GoRoute(
          path: RouterName.addAccount,
          name: RouterName.addAccount,
          builder: (context, state) {
            return const AddAccount();
          },
        ),
        GoRoute(
          path: RouterName.addDepartment,
          name: RouterName.addDepartment,
          builder: (context, state) {
            return const AddDepartmentPage();
          },
        ),
        GoRoute(
          path: RouterName.positionPage,
          name: RouterName.positionPage,
          builder: (context, state) {
            return const PositionPage();
          },
        ),
        GoRoute(
          path: RouterName.addPosition,
          name: RouterName.addPosition,
          builder: (context, state) {
            return const AddPosition();
          },
        ),
        GoRoute(
          path: RouterName.attendancePage,
          name: RouterName.attendancePage,
          builder: (context, state) {
            return const AttendancePage();
          },
        ),
        GoRoute(
          path: RouterName.updateEmployee,
          name: RouterName.updateEmployee,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => PersonelCubit(),
              child: UpdatePersonnel(
                employee: state.extra as PersonnelManagement,
              ),
            );
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
