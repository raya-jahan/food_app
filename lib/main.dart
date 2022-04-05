import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_app/view/authentication/sign_in.dart';
//import 'package:food_delivery_app/config/colors.dart';
import 'package:food_delivery_app/controllers/check_out_provider.dart';
import 'package:food_delivery_app/controllers/product_provider.dart';
import 'package:food_delivery_app/controllers/review_cart_provider.dart';
import 'package:food_delivery_app/controllers/user_provider.dart';
import 'package:food_delivery_app/controllers/wishlist_provider.dart';
import 'package:food_delivery_app/view/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
      ],
      child: MaterialApp(
        // theme: ThemeData(
        //     primaryColor: primaryColor,
        //     scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return HomeScreen();
            }
            return SignIn();
          },
        ),
      ),
    );
  }
}
