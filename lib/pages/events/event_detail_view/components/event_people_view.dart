import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_custom_button.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/models/User/user_response.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';

class EventPeopleView extends StatelessWidget {
  final List<User> users;

  const EventPeopleView({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventDetailViewModel controller = Get.find<EventDetailViewModel>();

    // Filtrar usuarios según el rol y el estado de confirmación
    final List<User> admins =
        users.where((user) => user.userRole == UserRole.admin).toList();

    final List<User> guests =
        users.where((user) => user.userRole == UserRole.guest).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 80,
                    child: CustomButton(
                      onPressed: () {},
                      icon: CupertinoIcons.person_2_fill,
                      label: "Agregar Gente",
                      color: Colors.green,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    height: 80,
                    child: CustomButton(
                      onPressed: () {
                        print("Xd");
                        controller.toggleEditMode();
                      },
                      icon: CupertinoIcons.pencil,
                      label: "Editar",
                      color: Colors.red,
                    ),
                  )),
            ],
          ),
          const Text(
            'Administradores',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          // Mostrar administradores
          if (admins.isNotEmpty)
            ...admins
                .map((user) => PersonTile(person: user, controller: controller))
                .toList(),
          if (admins.isEmpty) const Text('No hay administradores.'),
          const SizedBox(height: 16),
          const Text(
            'Invitados',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          // Mostrar invitados
          if (guests.isNotEmpty)
            ...guests
                .map((user) => PersonTile(person: user, controller: controller))
                .toList(),
          if (guests.isEmpty) const Text('No hay invitados.'),
        ],
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final User person;
  final EventDetailViewModel controller;

  const PersonTile({super.key, required this.person, required this.controller});

  @override
  Widget build(BuildContext context) {
    IconData confirmationIcon;

    // Asignar el ícono según el estado de confirmación
    switch (person.confirmationStatus) {
      case ConfirmationStatus.confirmed:
        confirmationIcon = Icons.check_circle; // Ícono para confirmados
        break;
      case ConfirmationStatus.pending:
        confirmationIcon = Icons.access_time; // Ícono para pendientes
        break;
      case ConfirmationStatus.unconfirmed:
        confirmationIcon = Icons.cancel; // Ícono para declinados
        break;
      default:
        confirmationIcon = Icons.help; // Ícono por defecto
        break;
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity, // Ocupa todo el ancho disponible
        margin: const EdgeInsets.only(bottom: 10.0), // Espaciado entre tarjetas
        decoration: BoxDecoration(
          color: AppColors.softBlack,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipOval(
                child: QSaleImage(
                  imgUrlString: person.thumbnail,
                  width: 40,
                  height: 40,
                  imgScale: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10), // Espaciado entre imagen y texto
              Expanded(
                child: Text(
                  person.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                person.confirmation ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(width: 10),
              Icon(
                confirmationIcon,
                color: person.confirmationStatus == ConfirmationStatus.confirmed
                    ? Colors.green // Color para confirmados
                    : person.confirmationStatus == ConfirmationStatus.pending
                        ? Colors.orange // Color para pendientes
                        : Colors.red, // Color para declinados
              ),
              const SizedBox(width: 10),
              // Si está en modo de edición, mostrar el botón de tres puntos
              Obx(() {
                return controller.isEditedModeActivated.value
                    ? PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'make_admin') {
                            // Lógica para hacer admin
                            // controller.makeUserAdmin(person);
                          } else if (value == 'remove') {
                            // Lógica para eliminar usuario
                            controller.updateAttendance(3);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem<String>(
                              value: 'make_admin',
                              child: Text('Hacer Admin'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'remove',
                              child: Text('Eliminar'),
                            ),
                          ];
                        },
                        icon: const Icon(CupertinoIcons.ellipsis),
                      )
                    : SizedBox(); // Si no está en modo de edición, no mostrar el botón
              }),
            ],
          ),
        ),
      ),
    );
  }
}
