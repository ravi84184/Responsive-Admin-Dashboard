import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/screens/components/drawer_list_tile.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/logowithtext.png"),
          ),
          DrawerListTile(
              title: 'Dash Board',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {
                Provider.of<Controller>(context, listen: false)
                    .changeMenu(context,MenuItem.Dashboard);
              }),
          DrawerListTile(
              title: 'Customer',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Provider.of<Controller>(context, listen: false)
                    .changeMenu(context,MenuItem.Customer);
              }),
          DrawerListTile(
              title: 'Order',
              svgSrc: 'assets/icons/Message.svg',
              tap: () {
                Provider.of<Controller>(context, listen: false)
                    .changeMenu(context,MenuItem.Order);
              }),
          DrawerListTile(
              title: 'Payment',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Provider.of<Controller>(context, listen: false)
                    .changeMenu(context,MenuItem.Payment);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Divider(
              color: grey,
              thickness: 0.2,
            ),
          ),
          DrawerListTile(
              title: 'Settings',
              svgSrc: 'assets/icons/Setting.svg',
              tap: () {}),
          DrawerListTile(
              title: 'Logout', svgSrc: 'assets/icons/Logout.svg', tap: () {}),
        ],
      ),
    );
  }
}
