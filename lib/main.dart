

import 'package:flutter_laravel/view/addProduct.dart';
import 'package:flutter_laravel/view/addUser.dart';
import 'package:flutter_laravel/view/listProducts.dart';
import 'package:flutter_laravel/view/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Codigo Alpha Flutter",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Codigo Alpha Flutter", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: Text("Main Page")),
      drawer: Drawer(
        child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text('Ejercicios'),
                  accountEmail: new Text('codigoalphacol@gmail.com'),
                  // decoration: new BoxDecoration(
                  //   image: new DecorationImage(
                  //     fit: BoxFit.fill,
                  //    // image: AssetImage('img/estiramiento.jpg'),
                  //   )
                  // ),
                ),
               new ListTile(
                  title: new Text("List Products"),
                  trailing: new Icon(Icons.help),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ListProducts(),
                  )),
                ),
                new ListTile(
                  title: new Text("Add Products"),
                  trailing: new Icon(Icons.help),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AddDataProduct(),
                  )),
                ),
                 new Divider(),
                new ListTile(
                  title: new Text("Register user"),
                  trailing: new Icon(Icons.fitness_center),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AddUser(),
                  )),
                ),
              ],
            ),
      ),
    );
  }
}
