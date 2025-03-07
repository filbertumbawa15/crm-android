import 'package:crm_android/components/image_preview_screen.dart';
import 'package:crm_android/components/input_decoration.dart';
import 'package:crm_android/components/upload_placeholder.dart';
import 'package:crm_android/constants/variables.dart';
import 'package:crm_android/models/response/customer_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VisitEntryScreen extends StatefulWidget {
  const VisitEntryScreen({super.key});

  @override
  State<VisitEntryScreen> createState() => _VisitEntryScreenState();
}

class _VisitEntryScreenState extends State<VisitEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
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
    // final pickedFile =
    //     await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   setState(() {
    //     if (isCheckIn) {
    //       _checkInPhoto = File(pickedFile.path);
    //     } else {
    //       _checkOutPhoto = File(pickedFile.path);
    //     }
    //   });
    // }
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
              DropdownButtonFormField<String>(
                style: const TextStyle(fontFamily: 'Lato'),
                value: selectedCustomer,
                decoration: borderinputDecoration("Select Customer"),
                items: customers.map((customer) {
                  return DropdownMenuItem<String>(
                    value: customer,
                    child: Text(
                      customer,
                      style: const TextStyle(fontFamily: 'Lato'),
                    ),
                  );
                }).toList(),
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
                      GestureDetector(
                        onTap: () => _pickImage(true),
                        child: _checkInPhoto != null
                            ? Image.file(_checkInPhoto!,
                                height: 100, fit: BoxFit.cover)
                            : uploadPlaceholder(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Check-out Photo",
                        style: TextStyle(
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _pickImage(true),
                        child: _checkInPhoto != null
                            ? Image.file(_checkInPhoto!,
                                height: 100, fit: BoxFit.cover)
                            : uploadPlaceholder(),
                      ),
                    ],
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
