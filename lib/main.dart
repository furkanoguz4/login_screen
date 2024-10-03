import 'package:flutter/material.dart';
import 'package:login_screen/Anasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

      String spKullaniciAdi =sp.getString("kullaniciAdi") ?? "Kullanıcı Adı Yok";
       String  spSifre = sp.getString("sifre")?? "Sifre Yok";
      if(spKullaniciAdi=="admin" && spSifre=="123"){
        return true;
      }
      else{
        return false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: FutureBuilder<bool>(
            future: oturumKontrol(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                  bool? gecisizni = snapshot.data;
                  return gecisizni! ? Anasayfa() : LoginEkrani();
              }
              else{
                return Container();
              }
            },),
    );
  }
}

class LoginEkrani extends StatefulWidget {

  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {
var tfKullaniciAdi = TextEditingController();
var tfSifre = TextEditingController();

var scaffoldKey = GlobalKey<ScaffoldState>();

Future<void> girisKontrol() async {
  var ka = tfKullaniciAdi.text;
  var s = tfSifre.text;

  if(ka=="admin" && s=="123"){
      var sp = await SharedPreferences.getInstance();
      sp.setString("kullaniciAdi", ka);
      sp.setString("sifre", s);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Anasayfa()));

  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Giriş Hatalı'),));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : scaffoldKey, //Snackbar için gerekli
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Giriş Yap"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: tfKullaniciAdi,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı" ,
                ),
              ),
              TextField(
                controller: tfSifre,
                decoration: InputDecoration(
                  hintText: "Şifre" ,
                ),
              ),
              ElevatedButton(onPressed: (){
                girisKontrol();
              }, child: Text("Giriş Yap"))
            ],
          ),
        ),
      ),
    );
  }
}
