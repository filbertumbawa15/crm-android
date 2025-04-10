import 'dart:io';
import 'dart:typed_data';
import 'package:crm_android/components/draw_large_text.dart';
import 'package:crm_android/components/image_preview_screen.dart';
import 'package:crm_android/components/load_bm_font.dart';
import 'package:crm_android/constants/variables.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:crm_android/components/input_decoration.dart';
import 'package:crm_android/components/upload_placeholder.dart';
import 'package:path_provider/path_provider.dart';

class VisitEntryScreen extends StatefulWidget {
  const VisitEntryScreen({super.key});

  @override
  State<VisitEntryScreen> createState() => _VisitEntryScreenState();
}

class _VisitEntryScreenState extends State<VisitEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  List<TextEditingController> picControllers = [TextEditingController()];
  TimeOfDay? _checkInTime;
  TimeOfDay? _checkOutTime;
  File? _checkInPhoto;
  File? _checkOutPhoto;

  final List<String> customers = [
    "Hospital ABC",
    "Mall XYZ",
    "Store 123",
    "Office DEF"
  ];

  String? selectedCustomer;

  // Function to select time
  Future<void> _selectTime(BuildContext context, bool isCheckIn) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInTime = picked;
        } else {
          _checkOutTime = picked;
        }
      });
    }
  }

  // Function to pick image
  Future<void> _pickImage(bool isCheckIn) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File originalFile = File(pickedFile.path);
      File stampedFile = await _addTimestamp(originalFile);
      setState(() {
        if (isCheckIn) {
          _checkInPhoto = File(stampedFile.path);
        } else {
          _checkOutPhoto = File(stampedFile.path);
        }
      });
    }
  }

  Future<File> _addTimestamp(File imageFile) async {
    img.Image image = img.decodeImage(await imageFile.readAsBytes())!;

    const now = '17 Feb 2025 16.26.56';

    final ByteData data = await rootBundle.load('assets/fonts/Unnamed.zip');
    final List<int> fontZipBytes = data.buffer.asUint8List();
    final font = img.BitmapFont.fromZip(fontZipBytes);

    int x = 10;
    int y = image.height - 850;

    final text = '''
$now
19 Jalan Ayahanda
Sei Putih Tengah
Kecamatan Medan Petisah
Kota Medan
Sumatera Utara''';

    final lines = text.split('\n');

    for (final line in lines) {
      img.drawString(image, line, font: font, x: x, y: y);
      y += font.lineHeight;
    }

    Directory tempDir = await getTemporaryDirectory();
    File newFile = File('${tempDir.path}/stamped_image.jpg')
      ..writeAsBytesSync(img.encodeJpg(image));

    return newFile;
  }

  // Submit Form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_checkInTime == null || _checkOutTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 170, 45, 36),
          content: Text("Please select both check-in and check-out time"),
        ));
        return;
      }
      if (_checkInPhoto == null || _checkOutPhoto == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please upload both check-in and check-out photos"),
        ));
        return;
      }

      // Save data or send to backend
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Visit entry saved successfully!"),
      ));
      Navigator.pop(context);
    }
  }

  void addAddressField() {
    setState(() {
      picControllers.add(TextEditingController());
    });
  }

  void _removeAddressField(int index) {
    setState(() {
      picControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Visit Sales Entry",
        style: TextStyle(fontFamily: 'Lato'),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // DropdownSearch<CustomersResponseModel>(
              //   showAsSuffixIcons: true,
              //   mode: Mode.BOTTOM_SHEET,
              //   dropdownBuilder: (context, selectedcontainer) {
              //     return Text(
              //       selectedcontainer == null
              //           ? ""
              //           : selectedcontainer.toString(),
              //       style: TextStyle(
              //         fontSize: 13.0,
              //         fontWeight: FontWeight.bold,
              //         color: selectedcontainer == null
              //             ? const Color.fromARGB(255, 114, 114, 114)
              //             : Colors.black,
              //       ),
              //     );
              //   },
              //   onFind: (String? filter) async {
              //     var response = await Dio().get(
              //       Variables.rapidApiUrl,
              //       queryParameters: {"filter": filter},
              //     );
              //     var models = CustomersResponseModel.fromListJson(json)

              //     return models;
              //   },
              //   dropdownSearchDecoration: const InputDecoration(
              //     label: Text("Container"),
              //     labelStyle: TextStyle(
              //       fontSize: 14.0,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     prefixIcon: Icon(
              //       Icons.book,
              //       color: Color(0xFF5599E9),
              //     ),
              //     contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              //     border: OutlineInputBorder(),
              //   ),
              //   onChanged: (data) {
              //     _container_id = data!.id;
              //   },
              //   popupTitle: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).primaryColorDark,
              //     ),
              //     child: const Center(
              //       child: Text(
              //         'Container',
              //         style: TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              DropdownSearch<String>(
                items: (String filter, LoadProps? props) async {
                  try {
                    final response = await Dio().get(
                      Variables.rapidApiUrl,
                    );

                    // Ubah hasil response sesuai struktur data dari API kamu
                    List<String> customers = (response.data as List)
                        .map((item) => item['name'].toString())
                        .toList();

                    return customers;
                  } catch (e) {
                    return [];
                  }
                },
                selectedItem: selectedCustomer,
                decoratorProps: DropDownDecoratorProps(
                  decoration: borderinputDecoration("Select Customer"),
                  baseStyle: const TextStyle(fontFamily: 'Lato'),
                ),
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              // Address
              TextField(
                style: const TextStyle(fontFamily: 'Lato'),
                controller: _addressController,
                decoration: borderinputDecoration("Address"),
              ),

              const SizedBox(height: 10),

              ...List.generate(picControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: TextField(
                          style: const TextStyle(fontFamily: 'Lato'),
                          controller: picControllers[index],
                          decoration: borderinputDecoration(
                              "PIC (Jabatan) ${index + 1}"),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: picControllers.length > 1
                          ? () => _removeAddressField(index)
                          : null,
                    ),
                  ],
                );
              }),

              const SizedBox(height: 10),

              // Check-in Time
              ListTile(
                title: Text(
                  _checkInTime == null
                      ? "Select Check-in Time"
                      : "Check-in: ${_checkInTime!.format(context)}",
                  style: const TextStyle(fontFamily: 'Lato'),
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context, true),
              ),

              // Check-out Time
              ListTile(
                title: Text(
                  _checkOutTime == null
                      ? "Select Check-out Time"
                      : "Check-out: ${_checkOutTime!.format(context)}",
                  style: const TextStyle(fontFamily: 'Lato'),
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context, false),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Check-in Photo",
                        style: TextStyle(
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _checkInPhoto != null
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImagePreviewScreen(
                                        imagePath: _checkInPhoto!),
                                  ),
                                );
                              },
                              child: Image.file(_checkInPhoto!,
                                  height: 150, width: 150, fit: BoxFit.cover),
                            )
                          : uploadPlaceholder(
                              onTap: () => _pickImage(true),
                            ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     const Text(
                  //       "Check-out Photo",
                  //       style: TextStyle(
                  //         fontFamily: 'Lato',
                  //       ),
                  //     ),
                  //     const SizedBox(height: 8),
                  //     GestureDetector(
                  //       onTap: () => _pickImage(true),
                  //       child: _checkInPhoto != null
                  //           ? Image.file(_checkInPhoto!,
                  //               height: 100, fit: BoxFit.cover)
                  //           : uploadPlaceholder(),
                  //     ),
                  //   ],
                  // ),
                ],
              ),

              // Check-out Photo
              // Row(
              //   children: [
              //     const Text("Check-in Photo",
              //         style: TextStyle(fontWeight: FontWeight.bold)),
              //     const SizedBox(height: 5),
              //     GestureDetector(
              //       onTap: () => _pickImage(true),
              //       child: _checkInPhoto != null
              //           ? Image.file(_checkInPhoto!,
              //               height: 100, fit: BoxFit.cover)
              //           : uploadPlaceholder(),
              //     ),
              //     const SizedBox(width: 10),
              //     const Text("Check-out Photo",
              //         style: TextStyle(fontWeight: FontWeight.bold)),
              //     const SizedBox(height: 5),
              //     GestureDetector(
              //       onTap: () => _pickImage(true),
              //       child: _checkInPhoto != null
              //           ? Image.file(_checkInPhoto!,
              //               height: 100, fit: BoxFit.cover)
              //           : uploadPlaceholder(),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  "Submit",
                  style: TextStyle(fontFamily: 'Lato'),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: addAddressField,
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah PIC"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
