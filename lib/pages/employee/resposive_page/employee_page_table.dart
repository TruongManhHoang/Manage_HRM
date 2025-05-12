import 'package:admin_hrm/common/widgets/containers/rounded_container.dart';
import 'package:admin_hrm/pages/dash_board/widgets/order_status_graph.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../table/data_table.dart';
import '../widgets/dash_board_card.dart';
import '../../../constants/sizes.dart';

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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => NewDepartmentPage()));
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
