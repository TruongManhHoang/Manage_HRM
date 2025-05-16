import 'package:admin_hrm/common/widgets/layouts/sidebars/bloc/sidebar_bloc.dart';
import 'package:admin_hrm/data/repository/contract_repository.dart';
import 'package:admin_hrm/data/repository/department_repository.dart';
import 'package:admin_hrm/data/repository/persional_repository.dart';

import 'package:admin_hrm/data/repository/disciplinary_repository.dart';
import 'package:admin_hrm/data/repository/reward_repository.dart';

import 'package:admin_hrm/data/repository/positiion_repository.dart';

import 'package:admin_hrm/data/repository/user_repository.dart';
import 'package:admin_hrm/local/hive_storage.dart';
import 'package:admin_hrm/service/auth_service.dart';
import 'package:admin_hrm/service/contract_service.dart';
import 'package:admin_hrm/service/department_service.dart';
import 'package:admin_hrm/service/persional_service.dart';

import 'package:admin_hrm/service/disciplinary_service.dart';
import 'package:admin_hrm/service/reward_service.dart';

import 'package:admin_hrm/service/positon_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> servicesLocator() async {
    final storage = GlobalStorageImpl();
    // final storage = StorageLocal();
    await storage.init();
    // final storage = GlobalStorageImpl();
    // await storage.init();

    // // 🟢 Đăng ký GlobalStorage
    getIt.registerSingleton<GlobalStorage>(storage);

    // 🟢 Đăng ký DataSource

    // 🟢 Đăng ký Repository

    // 🟢 Đăng ký UseCase

    // 🟢 Đăng ký Bloc

    getIt.registerSingleton<SideBarBloc>(SideBarBloc());
    getIt.registerSingleton<UserRepository>(UserRepository());
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<DepartmentService>(DepartmentService());
    getIt.registerSingleton<PositionService>(PositionService());
    getIt.registerSingleton<ContractService>(ContractService());
    getIt.registerSingleton<PersionalService>(PersionalService());
    getIt.registerSingleton<DepartmentRepository>(
        DepartmentRepository(getIt<DepartmentService>()));

    getIt.registerSingleton<RewardService>(RewardService());
    getIt.registerSingleton<RewardRepository>(
        RewardRepository(getIt<RewardService>()));

    getIt.registerSingleton<DisciplinaryService>(DisciplinaryService());
    getIt.registerSingleton<DisciplinaryRepository>(
        DisciplinaryRepository(getIt<DisciplinaryService>()));

    getIt.registerSingleton<PositiionRepository>(
        PositiionRepository(getIt<PositionService>()));
    getIt.registerSingleton<ContractRepository>(
        ContractRepository(getIt<ContractService>()));
    getIt.registerSingleton<PersionalRepository>(
        PersionalRepository(persionalService: getIt<PersionalService>()));
  }
}
