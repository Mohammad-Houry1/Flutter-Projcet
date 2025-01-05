import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/images.png'),
              backgroundColor: Colors.blue.shade50,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Welcome to GymClub!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Our mission is to empower your fitness journey with world-class tools and resources. From tailored exercises to expert tips, we are here to support beginners and seasoned athletes alike.',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade300, thickness: 1.5),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Icon(Icons.star, size: 50, color: Colors.amber),
                  SizedBox(height: 10),
                  Text(
                    'Why Choose Us?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We focus on personalized fitness experiences, comprehensive guidance, and innovative tools to make fitness accessible and enjoyable for everyone.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade300, thickness: 1.5),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Icon(Icons.people, size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text(
                    'Our Team',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A dedicated team of fitness enthusiasts and professionals working to make your journey smoother and more rewarding.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
