import 'package:admin_hrm/pages/dash_board/hello.dart';

import 'package:admin_hrm/constants/sizes.dart';

import 'package:flutter/material.dart';

class DepartmentPageDesktop extends StatelessWidget {
  const DepartmentPageDesktop({super.key});

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
                    'Quản lý phòng ban',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  //
                  Spacer(),
                  Icon(
                    Icons.apartment,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Quản lý phòng ban',
                    style: TextStyle(fontSize: 13, color: Colors.black),
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
                        const Text(
                          'Thao tác chức năng',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('Thêm phòng ban'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Tên phòng ban',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Mô tả',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Hủy'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Xử lý logic lưu dữ liệu ở đây
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Lưu'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 120,
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Thêm phòng ban')
                          ],
                        ),
                      ),
                    )
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
