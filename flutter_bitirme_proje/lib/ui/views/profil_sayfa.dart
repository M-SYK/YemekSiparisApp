import 'package:flutter/material.dart';
import 'package:flutter_bitirme_proje/ui/views/anasayfa.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({super.key});

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {
  int selectedIndex = 1;

  void onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Anasayfa()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo, title: const Text('Profil', style: TextStyle(fontSize: 18)),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Anasayfa()), (route) => false,);
          },icon: const Icon(Icons.arrow_back)
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 50,backgroundImage: AssetImage('assets/profil_ikon.jpg'), backgroundColor: Colors.indigo.shade100,),
                  const SizedBox(height: 8),
                  const Text('Kullanıcı Adı', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),),
                  const SizedBox(height: 4),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.indigo),
                    label: const Text('Düzenle', style: TextStyle(color: Colors.indigo)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3),),
                ],
              ),
              child: Column(
                children: [
                  const ListTile(title: Text('E-posta', style: TextStyle(color: Colors.indigo)), subtitle: Text('user@example.com'),),
                  const Divider(),
                  const ListTile(title: Text('Telefon', style: TextStyle(color: Colors.indigo)), subtitle: Text('+90 555 555 55 55'),),
                  const Divider(),
                  const ListTile(title: Text('Adresler', style: TextStyle(color: Colors.indigo)), subtitle: Text('Ev: 123 Sokak, İstanbul'),),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.indigo),
                    label: const Text('Yeni Adres Ekle', style: TextStyle(color: Colors.indigo)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),
              boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3),),
                ],
              ),
              child: const Column(
                children: [
                  ListTile(title: Text('Sipariş Geçmişi', style: TextStyle(color: Colors.indigo)), subtitle: Text('8 Ağustos 2024, Izgara Tavuk'),
                  ),
                  Divider(),
                  ListTile(title: Text('Sipariş Geçmişi', style: TextStyle(color: Colors.indigo)), subtitle: Text('07 Ağustos 2024, Makarna'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3),),
                ],
              ),
              child: Column(
                children: [
                  const ListTile(title: Text('Kayıtlı Kartlar', style: TextStyle(color: Colors.indigo)), subtitle: Text('**** **** **** 1234 [Visa]'),),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.indigo),
                    label: const Text('Kart Ekle', style: TextStyle(color: Colors.indigo)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ListTile(title: const Text('Ayarlar', style: TextStyle(color: Colors.indigo)), leading: const Icon(Icons.settings, color: Colors.indigo),
              onTap: () {},
            ),
            ListTile(title: const Text('Yardım', style: TextStyle(color: Colors.indigo)), leading: const Icon(Icons.help, color: Colors.indigo),
              onTap: () {},
            ),
            ListTile(title: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)), leading: const Icon(Icons.exit_to_app, color: Colors.red),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(
            label: 'Anasayfa',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Profil',
            icon: Icon(Icons.person),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            onItemTapped(index);
          });
        },
      ),
    );
  }
}
