import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bitirme_proje/data/entity/yemekler.dart';
import 'package:flutter_bitirme_proje/data/entity/yemekler_cevap.dart';

class YemeklerdaoRepo{
  List<Yemekler> parseYemekler(String cevap){
    return YemeklerCevap.fromJson(jsonDecode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async{
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }
}