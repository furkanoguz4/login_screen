import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String? spKullaniciAdi;
  String? spSifre;

  Future<void> oturumBilgisiOku() async {
    var sp = await SharedPreferences.getInstance();
     setState(() {
       spKullaniciAdi =sp.getString("kullaniciAdi") ?? "Kullanıcı Adı Yok";
       spSifre = sp.getString("sifre")?? "Sifre Yok";
     });
  }
  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("kullaniciAdi");
    sp.remove("sifre");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginEkrani()));

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oturumBilgisiOku();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("AnaSayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              cikisYap();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Kullanıcı adı : $spKullaniciAdi",style: TextStyle(fontSize: 24),),
              Text("Şifre : $spSifre ",style: TextStyle(fontSize: 24),),

            ],
          ),
        ),
      ),
    );
  }
}
