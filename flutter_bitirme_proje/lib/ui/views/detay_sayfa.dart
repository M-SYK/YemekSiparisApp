import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/yemekler.dart';
import '../cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  final Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int adet = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    int toplamFiyat = adet * widget.yemek.yemek_fiyat;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0,
        title: const Text("Ürün Detayı", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.close, color: Colors.indigo),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}", width: 200, height: 200,),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return const Icon(Icons.star, color: Colors.amber, size: 24);
              })
                ..add(const Icon(Icons.star_border, color: Colors.amber, size: 24)),
            ),
            const SizedBox(height: 16),
            Text("${widget.yemek.yemek_fiyat} ₺", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
            const SizedBox(height: 8),
            Text(widget.yemek.yemek_adi, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (adet > 1) {
                        adet--;
                      }
                    });
                  },icon: const Icon(Icons.remove_circle, color: Colors.indigo, size: 36),
                ),
                Text(adet.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
                IconButton(
                  onPressed: () {
                    setState(() {
                      adet++;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.indigo, size: 36),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Wrap(spacing: 8.0, runSpacing: 4.0,
              children: [
                Chip(label: Text('25-35 dk')),
                Chip(label: Text('Ücretsiz Teslimat')),
                Chip(label: Text('İndirim %10')),
              ],
            ),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$toplamFiyat ₺", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16), backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                  ),
                  onPressed: () {
                    context.read<DetaySayfaCubit>().sepeteYemekEkle(
                      widget.yemek.yemek_adi,
                      widget.yemek.yemek_resim_adi,
                      widget.yemek.yemek_fiyat,
                      adet,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ürün sepete eklendi.")),);
                  },
                  child: const Text("SEPETE EKLE", style: TextStyle(fontSize: 18, color: Colors.white),),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
