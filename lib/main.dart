import 'package:flutter/material.dart';
import 'barang_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  String kataCari = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Daftar Barang
    final List<Map<String, dynamic>> daftarBarang = [
      {'nama': 'Buku Tulis', 'kategori': 'ATK', 'anggota': 3000, 'umum': 3500, 'stok': 40},
      {'nama': 'Pulpen', 'kategori': 'ATK', 'anggota': 2500, 'umum': 3000, 'stok': 25},
      {'nama': 'Roti', 'kategori': 'Makanan', 'anggota': 5000, 'umum': 5500, 'stok': 15},
      {'nama': 'Susu Botol', 'kategori': 'Minuman', 'anggota': 4000, 'umum': 4500, 'stok': 0},
      {'nama': 'Pensil 2B', 'kategori': 'ATK', 'anggota': 2000, 'umum': 2500, 'stok': 30},
      {'nama': 'Penggaris 30cm', 'kategori': 'ATK', 'anggota': 1500, 'umum': 2000, 'stok': 30},
      {'nama': 'Keripik Kentang', 'kategori': 'Makanan', 'anggota': 3500, 'umum': 4000, 'stok': 20},
      {'nama': 'Air Mineral', 'kategori': 'Minuman', 'anggota': 2500, 'umum': 3000, 'stok': 50},
      {'nama': 'Teh Kemasan', 'kategori': 'Minuman', 'anggota': 3000, 'umum': 3500, 'stok': 0},
      {'nama': 'Susu Botol 2', 'kategori': 'Minuman', 'anggota': 4000, 'umum': 4500, 'stok': 10},
      {'nama': 'Pensil 2B 2', 'kategori': 'ATK', 'anggota': 2000, 'umum': 2500, 'stok': 30},
      {'nama': 'Gelas', 'kategori': 'ATK', 'anggota': 1500, 'umum': 2000, 'stok': 30},
      {'nama': 'Keripik Kaca', 'kategori': 'Makanan', 'anggota': 3500, 'umum': 4000, 'stok': 20},
    ];

    // filter stok
    final barangTersedia = daftarBarang.where((item) => item['stok'] > 0).toList();

    // filter kata pencarian
    final hasilCari = barangTersedia
        .where((b) => b['nama'].toLowerCase().contains(kataCari))
        .toList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Koperasi Sekolah')),
        body: Column(
          children: [
            // 1. kotak pencarian
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Cari barang...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (nilai) {
                  setState(() {
                    kataCari = nilai.toLowerCase();
                  });
                },
              ),
            ),
            
            // 2. daftar barang dalam bentuk kisi/grid responsif
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int kolom;
                  if (constraints.maxWidth < 600) {
                    kolom = 1;
                  } else if (constraints.maxWidth < 900) {
                    kolom = 2;
                  } else {
                    kolom = 3;
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kolom,
                      childAspectRatio: 3,
                    ),
                    itemCount: hasilCari.length,
                    itemBuilder: (context, index) {
                      final barang = hasilCari[index];

                      return BarangCard(
                        key: ValueKey('${barang['nama']}_$index'),
                        nama: barang['nama'],
                        hargaAnggota: barang['anggota'],
                        stok: barang['stok'],
                        kategori: barang['kategori'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}