import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/di/locator.dart';
import 'package:admin_hrm/local/hive_storage.dart';
import 'package:admin_hrm/pages/dash_board/hello.dart';
import 'package:admin_hrm/pages/department/department_page.dart';
import 'package:admin_hrm/pages/personnel_management/personnel_page.dart';
import 'package:admin_hrm/pages/position/position_page.dart';
import 'package:admin_hrm/router/app_routers.dart';
import 'package:admin_hrm/router/routers_name.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashBoardDesktopPage extends StatelessWidget {
  const DashBoardDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalStorage = getIt<GlobalStorage>();
    final personal = globalStorage.personalManagers;
    final department = globalStorage.departments;
    final position = globalStorage.positions;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.grey[200], // Đặt màu nền thành xám nhạt
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TBreadcrumsWithHeading(
                heading: 'Tổng quan',
                breadcrumbItems: [],
              ),
              Row(
                children: [
                  _buildDashboardCard(
                      '${personal!.length}',
                      'Nhân viên',
                      Colors.blue,
                      context,
                      Icons.person,
                      RouterName.employeePage,
                      'Xem danh sách nhân viên'),
                  _buildDashboardCard(
                      '${department!.length}',
                      'Phòng ban',
                      Colors.orange,
                      context,
                      Icons.apartment,
                      RouterName.departmentPage,
                      'Xem danh sách phòng ban'),
                  _buildDashboardCard(
                      '${position!.length}',
                      'Danh sách chức vụ',
                      const Color.fromARGB(255, 170, 158, 46),
                      context,
                      Icons.account_circle,
                      RouterName.positionPage,
                      'Xem danh sách tài khoản'),
                  _buildDashboardCard(
                      '0',
                      'Nhân viên nghỉ việc',
                      Colors.red,
                      context,
                      Icons.exit_to_app,
                      // Hello(),
                      'Xem nhân viên nghỉ việc'),
                ],
              ),
              Row(
                children: [
                  _buildDashboardCard('0', 'Nhóm nhân viên', Colors.blue,
                      context, Icons.group, 'Xem danh sách nhóm'),
                  _buildDashboardCard(
                      'EXCEL',
                      'Xuất báo cáo',
                      Colors.green,
                      context,
                      Icons.file_copy_outlined,
                      'Xem danh sách nhân viên'),
                  _buildDashboardCard('EXCEL', 'Xuất báo cáo', Colors.green,
                      context, Icons.file_copy_outlined, 'Xem lương nhân viên'),
                  _buildDashboardCard('EXCEL', 'Xuất báo cáo', Colors.green,
                      context, Icons.file_copy_outlined, 'Xem chấm công'),
                ],
              ),
              Row(
                children: [
                  _buildDashboardCard(
                      'EXCEL',
                      'Xuất báo cáo',
                      Colors.green,
                      context,
                      Icons.file_copy_outlined,
                      'Xem khen thưởng kỷ luật'),
                  _buildDashboardCard('', '', Colors.grey[200]!, context),
                  _buildDashboardCard('', '', Colors.grey[200]!, context),
                  _buildDashboardCard('', '', Colors.grey[200]!, context),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Danh sách phòng ban',
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Search',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 14.0), // Kích thước chữ
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(9)),
                            child: SingleChildScrollView(
                              scrollDirection:
                                  Axis.horizontal, // Cho phép cuộn ngang
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('STT')),
                                  DataColumn(label: Text('Mã Phòng')),
                                  DataColumn(label: Text('Tên Phòng')),
                                  DataColumn(label: Text('Vị trí')),
                                  DataColumn(label: Text('Ngày Tạo')),
                                  DataColumn(label: Text('Người tạo')),
                                  DataColumn(label: Text('Sửa')),
                                  DataColumn(label: Text('Xóa')),
                                  DataColumn(label: Text('Xóa')),
                                ],
                                // rows: []
                                rows: const [
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('001')),
                                    DataCell(Text('Phòng A')),
                                    DataCell(Text('Phòng A')),
                                    DataCell(Text('01/01/2024')),
                                    DataCell(Text('Admin')),
                                    DataCell(Text('Sửa')),
                                    DataCell(Text('Xóa')),
                                    DataCell(Text('Xóa')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('2')),
                                    DataCell(Text('002')),
                                    DataCell(Text('Phòng B')),
                                    DataCell(Text('Phòng A')),
                                    DataCell(Text('02/01/2024')),
                                    DataCell(Text('Admin')),
                                    DataCell(Text('Sửa')),
                                    DataCell(Text('Xóa')),
                                    DataCell(Text('Xóa')),
                                  ]),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Danh sách chức vụ',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Search',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 14.0), // Kích thước chữ
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(9)),
                              child: SingleChildScrollView(
                                scrollDirection:
                                    Axis.horizontal, // Cho phép cuộn ngang
                                child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('STT')),
                                      DataColumn(label: Text('Mã Chức Vụ')),
                                      DataColumn(label: Text('Tên Chức Vụ')),
                                      DataColumn(label: Text('Ngày Tạo')),
                                    ],
                                    // rows: [],
                                    rows: const [
                                      DataRow(cells: [
                                        DataCell(Text('1')),
                                        DataCell(Text('001')),
                                        DataCell(Text('Chức Vụ A')),
                                        DataCell(Text('01/01/2024')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('2')),
                                        DataCell(Text('002')),
                                        DataCell(Text('Chức Vụ B')),
                                        DataCell(Text('02/01/2024')),
                                      ]),
                                      // Bạn có thể thêm nhiều DataRow ở đây nếu cần
                                    ]),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget _buildDashboardCard(
    String count, String title, Color color, BuildContext context,
    [IconData? icon, String? router, String? name]) {
  return Expanded(
    child: InkWell(
      onTap: () {
        if (router != null) {
          context.go(router);
        }
      },
      child: Container(
        height: 170,
        margin:
            const EdgeInsets.only(top: 15.0, bottom: 15, left: 5, right: 20),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      count,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                if (icon != null)
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 96,
                  ),
              ],
            ),
            // const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 9.0),
              alignment: Alignment.center,
              child: Text(
                name ?? '',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
