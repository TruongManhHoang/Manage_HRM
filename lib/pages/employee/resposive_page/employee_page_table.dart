import 'package:flutter/material.dart';

class EmployeePageTablet extends StatelessWidget {
  const EmployeePageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'Nhân Viên',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('Thêm Nhân Viên',
                                style: Theme.of(context).textTheme.bodyMedium)),
                        TextButton(
                            onPressed: () {},
                            child: Text('Xuất danh sách nhân viên',
                                style: Theme.of(context).textTheme.bodyMedium)),
                        TextButton(
                            onPressed: () {},
                            child: Text('Hiện nhân viên đã ngừng hoạt động',
                                style: Theme.of(context).textTheme.bodyMedium)),
                        TextButton(
                            onPressed: () {},
                            child: Text('Nhân viên thôi việc',
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ],
                    ),
                    DataTable(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
