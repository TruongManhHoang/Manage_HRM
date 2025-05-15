import 'package:admin_hrm/data/model/department/department_model.dart';
import 'package:admin_hrm/data/model/disciplinary/disciplinary_model.dart';
import 'package:admin_hrm/data/model/reward/reward_model.dart';
import 'package:admin_hrm/data/repository/department_repository.dart';
import 'package:admin_hrm/data/repository/disciplinary_repository.dart';
import 'package:admin_hrm/data/repository/reward_repository.dart';
import 'package:admin_hrm/di/locator.dart';

import 'package:admin_hrm/pages/contract/contract_page.dart';
import 'package:admin_hrm/pages/contract/widgets/add_contract.dart';
import 'package:admin_hrm/pages/department/add_deparment/add_department_page.dart';
import 'package:admin_hrm/pages/department/bloc/department_event.dart';
import 'package:admin_hrm/pages/department/bloc/department_bloc.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/department/edit_deparment/edit_deparment.dart';
import 'package:admin_hrm/pages/disciplinary/add_edit_page/add_edit_disciplinary_page.dart';
import 'package:admin_hrm/pages/disciplinary/bloc/disciplinary_bloc.dart';
import 'package:admin_hrm/pages/disciplinary/bloc/disciplinary_event.dart';
import 'package:admin_hrm/pages/disciplinary/disciplinary.dart';
import 'package:admin_hrm/pages/employee/employee_page.dart';
import 'package:admin_hrm/pages/employee/widgets/add_employee.dart';
import 'package:admin_hrm/pages/auth/forget_password/forget_password.dart';
import 'package:admin_hrm/pages/auth/login/login_page.dart';
import 'package:admin_hrm/pages/auth/register/register_page.dart';
import 'package:admin_hrm/pages/position/position_page.dart';
import 'package:admin_hrm/pages/position/add_position/add_position.dart';
import 'package:admin_hrm/pages/reward/add_edit_page/add_edit_reward_page.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_bloc.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_event.dart';
import 'package:admin_hrm/pages/reward/reward_page.dart';

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

        //-------------------- Khen Thưởng --------------------//

        // GoRoute(
        //     path: RouterName.addReward,
        //     name: RouterName.addReward,
        //     builder: (context, state) {
        //       return BlocProvider(
        //         create: (context) => RewardBloc(
        //           getIt<RewardRepository>(),
        //         ),
        //         child: const AddRewardPage(),
        //       );
        //     }),
        ShellRoute(
            builder: (context, state, child) {
              return BlocProvider<RewardBloc>(
                create: (context) => RewardBloc(
                  getIt<RewardRepository>(),
                )..add(LoadRewards()),
                child: Scaffold(
                  body: child,
                ),
              );
            },
            routes: [
              GoRoute(
                  path: RouterName.rewardPage,
                  name: RouterName.rewardPage,
                  routes: [
                    GoRoute(
                      path: RouterName.editReward,
                      name: RouterName.editReward,
                      builder: (context, state) {
                        final reward = state.extra as RewardModel;
                        return AddAndEditRewardPage(
                          reward: reward,
                        );
                      },
                    ),
                    GoRoute(
                      path: RouterName.addReward,
                      name: RouterName.addReward,
                      builder: (context, state) {
                        return const AddAndEditRewardPage();
                      },
                    )
                  ],
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) => RewardBloc(
                        getIt<RewardRepository>(),
                      )..add(LoadRewards()),
                      child: const RewardPage(),
                    );
                  }),
            ]),

        ShellRoute(
            builder: (context, state, child) {
              return BlocProvider<DisciplinaryBloc>(
                create: (context) => DisciplinaryBloc(
                  getIt<DisciplinaryRepository>(),
                )..add(LoadDisciplinary()),
                child: Scaffold(
                  body: child,
                ),
              );
            },
            routes: [
              GoRoute(
                  path: RouterName.disciplinaryPage,
                  name: RouterName.disciplinaryPage,
                  routes: [
                    GoRoute(
                      path: RouterName.editDisciplinary,
                      name: RouterName.editDisciplinary,
                      builder: (context, state) {
                        final disciplinary = state.extra as DisciplinaryModel;
                        return AddAndEditDisciplinaryPage(
                          disciplinary: disciplinary,
                        );
                      },
                    ),
                    GoRoute(
                      path: RouterName.addDisciplinary,
                      name: RouterName.addDisciplinary,
                      builder: (context, state) {
                        return const AddAndEditDisciplinaryPage();
                      },
                    )
                  ],
                  builder: (context, state) {
                    return const DisciplinaryPage();
                  }),
            ])
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
