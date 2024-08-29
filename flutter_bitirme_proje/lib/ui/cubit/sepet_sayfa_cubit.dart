import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/sepet_yemekler.dart';
import '../../data/repo/sepet_yemeklerdao_repo.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super([]);

  var srepo = SepetYemeklerDaoRepo();

  Future<void> sepetiGetir(String kullanici_adi) async {
    var liste = await srepo.sepetiGetir(kullanici_adi);
    emit(liste);
  }

  Future<void> yemekSil(int sepet_yemek_id, String kullanici_adi) async {
    await srepo.yemekSil(sepet_yemek_id, kullanici_adi);
    await sepetiGetir(kullanici_adi);
  }
}
