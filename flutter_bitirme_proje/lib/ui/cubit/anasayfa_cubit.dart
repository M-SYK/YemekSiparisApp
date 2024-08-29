import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bitirme_proje/data/entity/yemekler.dart';
import 'package:flutter_bitirme_proje/data/repo/yemeklerdao_repo.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit():super(<Yemekler>[]);

  var yrepo = YemeklerdaoRepo();
  List<Yemekler> tumYemekler = [];

  Future<void> yemekleriYukle() async {
    tumYemekler = await yrepo.yemekleriYukle();
    emit(tumYemekler);
  }

  void aramaYap(String query) {
    if (query.isEmpty) {
      emit(tumYemekler);
    } else {
      emit(tumYemekler.where((yemek) => yemek.yemek_adi.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }
}
