import 'package:flutter/material.dart';
import 'package:flutter_bitirme_proje/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter_bitirme_proje/ui/cubit/detay_sayfa_cubit.dart';
import 'package:flutter_bitirme_proje/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:flutter_bitirme_proje/ui/views/anasayfa.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

