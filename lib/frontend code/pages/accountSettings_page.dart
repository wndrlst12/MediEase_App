import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/profileManagement_page.dart';

class AccountsettingsPage extends StatelessWidget {
  AccountsettingsPage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff9AD4CC),
        title: Text("Account Settings"),
        titleTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: currentUser!.photoURL != null
                        ? NetworkImage(currentUser!.photoURL!)
                        : null,
                    child: currentUser!.photoURL == null
                        ? Text(currentUser!.displayName?[0] ?? '')
                        : null,
                    radius: 40,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Account",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                           "Make changes to your account",
                          style: TextStyle(
                            
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _buildSection(
              context,
              [
                _buildListTile(
                  "Profile Management",
                  "",
                  Icons.arrow_forward,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilemanagementPage(),
                      ),
                    );
                    // Navigate to AccountSettingsPage
                  },
                ),
                _buildListTile(
                  "Password and Privacy",
                  "",
                  Icons.arrow_forward,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountsettingsPage(),
                      ),
                    );
                  },
                ),
                _buildListTile(
                  "Delete Account",
                  "",
                  Icons.arrow_forward,
                  () {
                    // Feedback navigation
                  },
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(5.0),
      child: Column(children: tiles),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    IconData trailingIcon,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: TextStyle(fontSize: 10))
          : null,
      trailing: GestureDetector(
        onTap: onTap,
        child: Icon(trailingIcon),
      ),
    );
  }
}
