import 'package:admin_hrm/data/model/department/department_model.dart';
import 'package:admin_hrm/data/repository/department_repository.dart';
import 'package:admin_hrm/di/locator.dart';

import 'package:admin_hrm/pages/contract/contract_page.dart';
import 'package:admin_hrm/pages/contract/widgets/add_contract.dart';
import 'package:admin_hrm/pages/department/add_deparment/add_department_page.dart';
import 'package:admin_hrm/pages/department/bloc/department_event.dart';
import 'package:admin_hrm/pages/department/bloc/department_bloc.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/department/edit_deparment/edit_deparment.dart';
import 'package:admin_hrm/pages/employee/employee_page.dart';
import 'package:admin_hrm/pages/employee/widgets/add_employee.dart';
import 'package:admin_hrm/pages/auth/forget_password/forget_password.dart';
import 'package:admin_hrm/pages/auth/login/login_page.dart';
import 'package:admin_hrm/pages/auth/register/register_page.dart';
import 'package:admin_hrm/pages/position/position_page.dart';
import 'package:admin_hrm/pages/position/add_position/add_position.dart';
import 'package:admin_hrm/pages/salary/add_deparment/add_salary_page.dart';
import 'package:admin_hrm/pages/salary/salary_page.dart';

import 'package:admin_hrm/router/router_observer.dart';
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
              return BlocProvider(
                create: (context) =>
                    DepartmentBloc(repository: getIt<DepartmentRepository>())
                      ..add(GetListDepartment()),
                child: const DepartmentPage(),
              );
            }),
        GoRoute(
          path: RouterName.employeePage,
          name: RouterName.employeePage,
          builder: (context, state) {
            return const EmployeePage();
          },
        ),
        GoRoute(
          path: RouterName.addEmployee,
          name: RouterName.addEmployee,
          builder: (context, state) {
            return const AddEmployee();
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
        ShellRoute(
            builder: (context, state, child) {
              return BlocProvider<DepartmentBloc>(
                create: (context) =>
                    DepartmentBloc(repository: getIt<DepartmentRepository>()),
                child: Scaffold(
                  body: child,
                ),
              );
            },
            routes: [
              GoRoute(
                path: RouterName.addDepartment,
                name: RouterName.addDepartment,
                builder: (context, state) {
                  return const AddDepartmentPage();
                },
              ),
              GoRoute(
                path: RouterName.editDepartment,
                name: RouterName.editDepartment,
                builder: (context, state) {
                  final department = state.extra as DepartmentModel;
                  return EditDepartmentPage(
                    department: department,
                  );
                },
              )
            ]),
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
          path: RouterName.salaryPage,
          name: RouterName.salaryPage,
          builder: (context, state) {
            return const SalaryPage();
          },
        ),
        GoRoute(
          path: RouterName.addSalary,
          name: RouterName.addSalary,
          builder: (context, state) {
            return const AddSalaryPage();
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
