import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/constants/responsive.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/screens/order_page/order_page.dart';
import 'package:responsive_admin_dashboard/screens/payment_page/payment_page.dart';

import 'company_page/company_page.dart';
import 'components/custom_appbar.dart';
import 'components/dashboard_content.dart';
import 'components/drawer_menu.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      key: context.read<Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: DrawerMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppbar(),
                  Expanded(
                    child: Consumer<Controller>(
                      builder: (BuildContext context, value, Widget? child) {
                        if (value.selectedMenu == MenuItem.Dashboard) {
                          return DashboardContent();
                        }
                        if (value.selectedMenu == MenuItem.Customer) {
                          return CompanyPage();
                        }
                        if (value.selectedMenu == MenuItem.Payment) {
                          return PaymentPage();
                        }
                        if (value.selectedMenu == MenuItem.Order) {
                          return OrderPage();
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
