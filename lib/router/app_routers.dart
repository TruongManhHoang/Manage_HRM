import 'package:admin_hrm/pages/contract/contract_page.dart';
import 'package:admin_hrm/pages/contract/widgets/add_contract.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/employee/employee_page.dart';
import 'package:admin_hrm/pages/employee/widgets/add_employee.dart';
import 'package:admin_hrm/pages/login/login_page.dart';

import 'package:admin_hrm/router/router_observer.dart';
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
          path: RouterName.login,
          name: RouterName.login,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => DashboardBloc(),
              child: const LoginPage(),
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
