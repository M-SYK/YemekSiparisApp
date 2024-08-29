import 'package:flutter_bitirme_proje/data/entity/sepet_yemekler.dart';

class SepetYemeklerCevap {
  int success;
  List<SepetYemekler> sepetYemekler;

  SepetYemeklerCevap({required this.success, required this.sepetYemekler});

  factory SepetYemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List?;
    List<SepetYemekler> sepetYemeklerListesi = jsonArray != null
        ? jsonArray.map((item) => SepetYemekler.fromJson(item)).toList()
        : [];

    return SepetYemeklerCevap(
      success: json["success"] as int,
      sepetYemekler: sepetYemeklerListesi,
    );
  }
}
