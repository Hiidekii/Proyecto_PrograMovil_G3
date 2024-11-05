import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/models/User/user_response.dart';

class EventPeopleView extends StatelessWidget {
  final List<User> users;

  const EventPeopleView({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filtrar usuarios según el rol y el estado de confirmación
    final List<User> admins =
        users.where((user) => user.userRole == UserRole.admin).toList();

    final List<User> guests =
        users.where((user) => user.userRole == UserRole.guest).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            ...admins.map((user) => PersonTile(person: user)).toList(),
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
            ...guests.map((user) => PersonTile(person: user)).toList(),
          if (guests.isEmpty) const Text('No hay invitados.'),
        ],
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final User person;

  const PersonTile({super.key, required this.person});

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
            ],
          ),
        ),
      ),
    );
  }
}
