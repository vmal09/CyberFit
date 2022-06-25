import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: ContactUs(
          companyName: '\n\nNIKE',
          tagLine: 'Johore Premium Outlet\n',
          instagram:
              'https://www.instagram.com/explore/locations/237848292/malaysia/senai-johor-malaysia/nike-johor-premium-outlet/',
          phoneNumber: '+91123456789',
          facebookHandle:
              'https://m.facebook.com/profile.php?id=438496712926871',
          dividerThickness: 3,
          website: 'https://www.nike.com/',
          email: 'https://www.premiumoutlets.com.my/contact-us',
          companyColor: Color.fromARGB(255, 0, 0, 0),
          cardColor: Color.fromARGB(255, 221, 200, 6),
          textColor: Color.fromARGB(255, 0, 0, 0),
          taglineColor: Color.fromARGB(255, 7, 0, 105),
        ),
      ),
    );
  }
}
