import 'package:admin_hrm/data/model/department/department_model.dart';
import 'package:admin_hrm/service/department_service.dart';

class DepartmentRepository {
  final DepartmentService _departmentService;
  DepartmentRepository(this._departmentService);
  Future<void> createDepartment(DepartmentModel departmentModel) async {
    await _departmentService.addDepartment(departmentModel);
  }

  Future<List<DepartmentModel>> getDepartments() async {
    return await _departmentService.getDepartments();
  }

  Future<void> updateDepartment(DepartmentModel departmentModel) async {
    await _departmentService.updateDepartment(departmentModel);
  }

  Future<void> deleteDepartment(String id) async {
    await _departmentService.deleteDepartment(id);
  }
}
