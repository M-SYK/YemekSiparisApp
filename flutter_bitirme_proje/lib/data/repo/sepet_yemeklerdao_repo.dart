import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bitirme_proje/data/entity/sepet_yemekler.dart';
import 'package:flutter_bitirme_proje/data/entity/sepet_yemekler_cevap.dart';


class SepetYemeklerDaoRepo {
  List<SepetYemekler> parseSepetYemekler(String cevap) {
    return SepetYemeklerCevap.fromJson(jsonDecode(cevap)).sepetYemekler;
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Sepete Ekleme: ${cevap.data}");
  }

  Future<List<SepetYemekler>> sepetiGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }


  Future<void> yemekSil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi};
    await Dio().post(url, data: FormData.fromMap(veri));
  }
}
