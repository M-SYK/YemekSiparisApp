import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/sepet_yemeklerdao_repo.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(null);

  var srepo = SepetYemeklerDaoRepo();

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet) async {
    await srepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, "mahsun");
  }
}
