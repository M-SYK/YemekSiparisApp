import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/sepet_yemekler.dart';
import '../cubit/sepet_sayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {
  @override
  _SepetSayfaState createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  String kullanici_adi = "mahsun";

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetiGetir(kullanici_adi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0,
        title: const Text("Sepetim", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.close, color: Colors.black),
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepetYemeklerListesi) {
          if (sepetYemeklerListesi.isNotEmpty) {
            int toplamFiyat = sepetYemeklerListesi.fold(0, (previousValue, element) =>
            previousValue + (element.yemek_fiyat * element.yemek_siparis_adet)
            );
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetYemeklerListesi.length,
                    itemBuilder: (context, indeks) {
                      var sepetYemek = sepetYemeklerListesi[indeks];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}", width: 75, height: 75, fit: BoxFit.cover,),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(sepetYemek.yemek_adi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
                                    const SizedBox(height: 4),
                                    Text("Fiyat: ₺${sepetYemek.yemek_fiyat}", style: TextStyle(fontSize: 14),),
                                    Text("Adet: ${sepetYemek.yemek_siparis_adet}", style: TextStyle(fontSize: 14),),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text("₺${sepetYemek.yemek_fiyat * sepetYemek.yemek_siparis_adet}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),),
                                  IconButton(
                                      onPressed: () {
                                      context.read<SepetSayfaCubit>().yemekSil(sepetYemek.sepet_yemek_id, kullanici_adi,);
                                    },icon: const Icon(Icons.delete, color: Colors.red)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gönderim Ücreti", style: TextStyle(fontSize: 16),),
                          Text("₺0", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Toplam:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                          Text("₺$toplamFiyat", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                          ),
                          child: const Text("SEPETİ ONAYLA", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Sepetiniz boş.", style: TextStyle(fontSize: 18),),
            );
          }
        },
      ),
    );
  }
}
