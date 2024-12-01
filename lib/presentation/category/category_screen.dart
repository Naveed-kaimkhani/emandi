
import 'package:e_mandi/presentation/billing/backup_data.dart';
import 'package:e_mandi/presentation/category/category_container.dart';
import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Function to handle the logout action
  void logout() {
    // Add your logout logic here
    print("Logged out");
    Navigator.pushNamed(context, RoutesName.login); // Redirect to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.backgroundColor,
      appBar: AppBar(
        backgroundColor: Styling.primaryColor, // Set to your desired color
      ),
      // Drawer (Sidebar) implementation
      drawer: drawerWidget(context),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          Image.asset(
            Images.logo_en,
            height: 260.h,
            width: 260.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryContainer(
                imagePath: Images.initial,
                text: AppLocalizations.of(context)!.iNITIAL,
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.initialScreen);
                },
              ),
              CategoryContainer(
                imagePath: Images.billing,
                text: AppLocalizations.of(context)!.bILLING,
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.billingScreen);
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryContainer(
                imagePath: Images.ledger,
                text: AppLocalizations.of(context)!.lEDGES,
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.ledgesScreen);
                },
              ),
              CategoryContainer(
                imagePath: Images.connection,
                text: AppLocalizations.of(context)!.cONNECTIONS,
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.connectionScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Drawer drawerWidget(BuildContext context) {
    return Drawer(
      // backgroundColor: Styling.backgroundColor,
      child: Container(
        color: Colors.white, // Green background color
        // Set the drawer background color to white or any other color

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
  
            CustomDrawerHeader(
              accountName: "Ameer Jan", // Replace with dynamic data if needed
              accountEmail:
                  "ameerjan@gmail.com", // Replace with dynamic data if needed
              profileIcon: Icons.person, // Optional: change the icon
            ),
            // Drawer items for different modules
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category"),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.categoryScreen);
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text(AppLocalizations.of(context)!.bILLING),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.billingScreen);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text(AppLocalizations.of(context)!.lEDGES),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.ledgesScreen);
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text(AppLocalizations.of(context)!.connection),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.connectionScreen);
              },
            ),
            Divider(),
            // Backup Button
            ListTile(
              leading: Icon(Icons.backup),
              title: Text("Backup"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BackupPage()),
                );
              }, // Call backup function
            ),
            // Logout Button
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: logout, // Call logout function
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerHeader extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final IconData profileIcon;

  const CustomDrawerHeader({
    Key? key,
    required this.accountName,
    required this.accountEmail,
    this.profileIcon = Icons.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Styling.primaryColor, // Background color
      ),
      accountName: Text(
        accountName,
        style: TextStyle(
          color: Colors.white, // Text color
        ),
      ),
      accountEmail: Text(
        accountEmail,
        style: TextStyle(
          color: Colors.white, // Text color
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          profileIcon,
          color: Colors.black,
        ),
      ),
    );
  }
}
