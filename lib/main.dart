import 'package:flutter/material.dart';
import 'package:productos_app/screens/register_screen.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: ( _ ) =>AuthService()),
        ChangeNotifierProvider(create: ( _ ) =>ProductsService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {

        'cheking'     :( _ ) => CheckAuthScreen(),

        'home'        :( _ ) => HomeScreen(),
        'product'     :( _ ) => ProductScreen(),

        'login'       :( _ ) => LoginScreen(), 
        'register'    :( _ ) => RegisterScreen(),
      },
        scaffoldMessengerKey: NotificationsServices.messengerKey,
        theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
        )
      ),
  
  
    );
  }
}