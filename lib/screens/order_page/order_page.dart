import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/constants/responsive.dart';
import 'package:responsive_admin_dashboard/screens/order_page/controller/order_controller.dart';

import 'create_order_dialog/create_order_dialog.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<OrderController>(context, listen: false)
          .getOrderList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Orders",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    if (Responsive.isMobile(context)) {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateOrderDialog()));
                      if (result != null && result == true)
                        Provider.of<OrderController>(context, listen: false)
                            .getOrderList(context);
                    } else {
                      var result = await showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: CreateOrderDialog(),
                            );
                          });
                      if (result != null && result == true)
                        Provider.of<OrderController>(context, listen: false)
                            .getOrderList(context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      "Add Order",
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            Consumer<OrderController>(builder: (context, data, child) {
              return Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      _tableHeader("Company Name"),
                      _tableHeader("Invoice"),
                      _tableHeader("Date"),
                      _tableHeader("Amount"),
                      _tableHeader("Action"),
                    ],
                  ),
                  if (data.orderList != null)
                    for (var model in data.orderList!)
                      TableRow(
                        children: [
                          _tableBody("${model.companyName}"),
                          _tableBody("${model.invoiceNo}"),
                          _tableBody("${model.date}"),
                          _tableBody("${model.amount}"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*Icon(Icons.edit),
                              SizedBox(
                                width: 10,
                              ),*/
                              InkWell(
                                onTap: (){
                                  data.deleteOrder(context, model.orderId);
                                },
                                child: Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  _tableHeader(String title) {
    return Container(
      color: Colors.grey.shade50,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  _tableBody(String title) {
    return Container(
      color: Colors.grey.shade50,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(),
      ),
    );
  }
}
