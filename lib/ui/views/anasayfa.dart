import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bitirme_proje/ui/views/profil_sayfa.dart';
import 'package:flutter_bitirme_proje/ui/views/sepet_sayfa.dart';
import 'package:flutter_bitirme_proje/ui/cubit/anasayfa_cubit.dart';
import '../../data/entity/yemekler.dart';
import 'detay_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int selectedIndex = 0;
  TextEditingController aramaController = TextEditingController();
  FocusNode aramaFocusNode = FocusNode();
  bool clearIconVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();

    aramaFocusNode.addListener(() {
      setState(() {
        clearIconVisible = aramaFocusNode.hasFocus;
      });
    });
  }

  void onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilSayfa()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomAppBarClipper(),
                child: Container(height: 200,
                  color: Colors.indigo,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mutfak Kapında", style: TextStyle(fontFamily: "Pacifico", fontSize: 22, color: Colors.white,),
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Teslimat Adresi', style: TextStyle(color: Colors.white, fontFamily: "Pacifico",),),
                                Text('Evim', style: TextStyle(fontFamily: "Pacifico", fontWeight: FontWeight.bold, color: Colors.white,),),
                              ],
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.home, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: aramaController,
                      focusNode: aramaFocusNode,
                      onChanged: (query) {
                        context.read<AnasayfaCubit>().aramaYap(query);
                      },
                      decoration: InputDecoration(
                        suffixIcon: clearIconVisible
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            aramaController.clear();
                            context.read<AnasayfaCubit>().aramaYap('');
                            setState(() {
                              clearIconVisible = false;
                              aramaFocusNode.unfocus();
                            });
                          },
                        )
                            : null,
                        hintText: 'Ara',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          clearIconVisible = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
              builder: (context, yemeklerListesi) {
                if (yemeklerListesi.isNotEmpty) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: yemeklerListesi.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3, crossAxisSpacing: 8, mainAxisSpacing: 8,),
                    itemBuilder: (context, indeks) {
                      var yemek = yemeklerListesi[indeks];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek),),);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                  child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}", fit: BoxFit.cover,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(yemek.yemek_adi, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                                    const Row(
                                      children: [
                                        Icon(Icons.delivery_dining, size: 16, color: Colors.green,),
                                        SizedBox(width: 4),
                                        Text('Ücretsiz Teslimat', style: TextStyle(fontSize: 12, color: Colors.green,),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${yemek.yemek_fiyat} ₺", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                                        IconButton(
                                          onPressed: () {
                                          },icon: const Icon(Icons.add_circle, color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(label: 'Anasayfa', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Profil', icon: Icon(Icons.person)),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            onItemTapped(index);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
