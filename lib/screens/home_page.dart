import 'package:flutter/material.dart';
import 'package:forms/components/linear_gradient.dart';
import 'package:forms/screens/new_client_page.dart';
import 'package:forms/screens/product_list.dart';
import 'package:forms/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_rounded,
        //     color: Colors.white,
        //   ),
        // ),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              sharedPreferences.remove('email');
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
        elevation: 3,
      ),
      body: GradientContainer(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              color: Colors.indigo.shade700,
              child: const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 4,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageNewClient(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.none,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/one.jpg',
                              height: 75,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'New Client',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageProductList(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.none,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/two.jpg',
                              height: 75,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Product List',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
