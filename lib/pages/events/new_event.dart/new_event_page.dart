import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/extensions/time_extensions.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/location_modal_page.dart';
import 'new_event_view_model.dart'; // Asegúrate de importar el ViewModel

class NewEventPage extends StatelessWidget {
  const NewEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia del controlador usando GetX
    final NewEventViewModel viewModel = Get.put(NewEventViewModel());

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 0,
          right: 0,
          top: 0),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Nuevo evento',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBackgroundColor,
                  ),
                ),
              ),
              Text(
                viewModel.imageBase64.value.isNotEmpty
                    ? "Imagen del evento"
                    : "Selecciona una imagen",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final pickedImg = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedImg != null) {
                    File imageFile = File(pickedImg.path);
                    List<int> imageBytes = await imageFile.readAsBytes();
                    String base64Image = base64Encode(imageBytes);
                    viewModel.imageBase64.value = base64Image;
                  }
                },
                child: Obx(() {
                  return Stack(
                    alignment: Alignment
                        .center, // Alinea todos los hijos del Stack en el centro
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: viewModel.imageBase64.value.isNotEmpty
                            ? MemoryImage(
                                base64Decode(viewModel.imageBase64.value))
                            : const AssetImage('assets/placeholder_image.png')
                                as ImageProvider,
                      ),
                      const Icon(
                        CupertinoIcons.photo,
                        size: 50,
                        color: AppColors.yellow,
                      ),
                    ],
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(
                              value: viewModel.isPublic.value,
                              onChanged: (value) {
                                viewModel.setEventVisibility(value);
                              },
                              activeColor: AppColors.red,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Evento público',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              _buildTextField(
                CupertinoIcons.tickets,
                'Título',
                (value) => viewModel.title.value = value,
              ),
              const SizedBox(height: 2),
              // Fecha
              _buildDateField(context, viewModel),
              const SizedBox(height: 2),
              // Hora
              _buildTimeField(context, viewModel),
              const SizedBox(height: 2),
              // Descripción
              _buildTextField(
                CupertinoIcons.text_alignleft,
                'Descripción',
                (value) => viewModel.description.value = value,
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return const LocationModal();
                    },
                  );
                },
                child: Obx(() {
                  final address =
                      viewModel.selectedPlace.value?.displayName.text;
                  return _buildPlainText(CupertinoIcons.location_solid,
                      "Selecciona una dirección", address);
                }),
              ),

              const SizedBox(height: 2),
              _buildTextField(
                CupertinoIcons.chat_bubble_text,
                'Link de chat',
                (value) => viewModel.chatLink.value = value,
              ),
              const SizedBox(height: 2),
              _buildTextField(
                CupertinoIcons.music_note,
                'Link de la playlist',
                (value) => viewModel.playlistLink.value = value,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      viewModel.clearEventForm();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.submitEvent(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                    ),
                    child: const Text('Aceptar'),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, String hintText, Function(String) onChanged) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.darkBackgroundColor),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ));
  }

  Widget _buildPlainText(IconData icon, String hint, String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(icon, color: AppColors.darkBackgroundColor),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text ?? hint,
                  style: TextStyle(
                    color: text == null
                        ? Colors.grey
                        : AppColors.darkBackgroundColor,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // Solo muestra una línea
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, NewEventViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          locale: const Locale("es", "ES"),
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
          builder: (BuildContext context, Widget? widget) => Theme(
            data: ThemeData(
              colorScheme:
                  const ColorScheme.light(primary: Colors.orangeAccent),
              datePickerTheme: const DatePickerThemeData(
                backgroundColor: AppColors.cream,
                dividerColor: AppColors.yellow,
                headerBackgroundColor: AppColors.yellow,
                headerForegroundColor: AppColors.red,
              ),
            ),
            child: widget!,
          ),
        );
        if (pickedDate != null) {
          viewModel.date.value = pickedDate;
        }
      },
      child: Obx(() => _buildPlainText(
          CupertinoIcons.time,
          "Selecciona una Fecha",
          viewModel.date.value?.formatToCustomString())),
    );
  }

  Widget _buildTimeField(BuildContext context, NewEventViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: viewModel.time.value ?? TimeOfDay.now(),
          builder: (BuildContext context, Widget? widget) => Theme(
            data: ThemeData(
              colorScheme:
                  const ColorScheme.light(primary: Colors.orangeAccent),
              datePickerTheme: const DatePickerThemeData(
                backgroundColor: AppColors.cream,
                dividerColor: AppColors.yellow,
                headerBackgroundColor: AppColors.yellow,
                headerForegroundColor: AppColors.red,
                rangeSelectionBackgroundColor: AppColors.red,
              ),
            ),
            child: widget!,
          ),
        );

        if (pickedTime != null) {
          viewModel.time.value = pickedTime;
        }
      },
      child: Obx(() => _buildPlainText(CupertinoIcons.time,
          "Selecciona una hora", viewModel.time.value?.formatToCustomString())),
    );
  }
}
