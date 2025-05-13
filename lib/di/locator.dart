import 'package:admin_hrm/common/widgets/layouts/sidebars/bloc/sidebar_bloc.dart';
import 'package:admin_hrm/local/hive_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> servicesLocator() async {
    // final storage = GlobalStorageImpl();
    // await storage.init();

    // // 🟢 Đăng ký GlobalStorage
    // getIt.registerSingleton<GlobalStorage>(storage);

    // 🟢 Đăng ký DataSource

    // 🟢 Đăng ký Repository

    // 🟢 Đăng ký UseCase

    // 🟢 Đăng ký Bloc

    getIt.registerSingleton<SideBarBloc>(SideBarBloc());
  }
}
