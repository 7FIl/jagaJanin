import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Tools/TextField_interface.dart';

class Halaman3 extends StatefulWidget {
  const Halaman3({super.key});

  @override
  State<Halaman3> createState() => _Halaman3State();
}

class _Halaman3State extends State<Halaman3> {
  String? _pilihanAktivitas;
  String pilihan = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        new Center(
                          child: Text(
                            'Asupan sehari-hari',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        CustomTextField(
                          judulAtas: "Makan berapa kali sehari?",
                          labelInput: "Jumlah Makan per Hari",
                          hintInput: "Contoh: 3",
                          textBelakang: null,
                          ikonKiri: Icons.restaurant,
                          controller: null,
                        ),

                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Jenis lauk apa yang sering dikonsumsi?",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        DropdownMenu<String>(
                          initialSelection: _pilihanAktivitas,
                          width: MediaQuery.of(context).size.width * 0.85,
                          hintText: "Pilihan lauk yang sering dikonsumsi", textStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: Color(0xFFF48FB1),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: Color(0xFFF48FB1),
                                width: 2,
                              ),
                            ),
                          ),
                          onSelected: (String? nilaiBaru) {
                            setState(() {
                              _pilihanAktivitas = nilaiBaru;
                              pilihan = nilaiBaru ?? '';
                            });
                          },
                          trailingIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFFF48FB1),
                          ),
                          selectedTrailingIcon: const Icon(
                            Icons.arrow_drop_up,
                            color: Color(0xFFF48FB1),
                          ),

                          menuStyle: MenuStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.pink.shade50,
                            ),
                          ),

                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: 'Tempe',
                              label: 'Tempe',
                              labelWidget: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.7, 
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF48FB1), 
                                      width:
                                          0.5, 
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ), 
                                child: const Text('Tempe'),
                              ),
                            ),

                            DropdownMenuEntry(
                              value: 'Tahu',
                              label: 'Tahu',
                              labelWidget: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.7, 
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF48FB1), 
                                      width:
                                          0.5, 
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ), 
                                child: const Text('Tahu'),
                              ),
                            ),

                            DropdownMenuEntry(
                              value: 'Ayam',
                              label: 'Ayam',
                              labelWidget: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.7, 
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF48FB1), 
                                      width:
                                          0.5, 
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ), 
                                child: const Text('Ayam'),
                              ),
                            ),

                            DropdownMenuEntry(
                              value: 'Ikan',
                              label: 'Ikan',
                              labelWidget: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.7, 
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF48FB1), 
                                      width:
                                          0.5, 
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ), 
                                child: const Text('Ikan'),
                              ),
                            ),

                            DropdownMenuEntry(
                              value: 'Telur Ayam',
                              label: 'Telur Ayam',
                              labelWidget: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.7, 
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF48FB1), 
                                      width:
                                          0.5, 
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ), 
                                child: const Text('TelurAyam'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
