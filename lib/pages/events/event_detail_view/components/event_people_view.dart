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
    return SizedBox(
      height: 400,
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Cambia este valor para más o menos columnas
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio:
              2, // Cambiado para que las celdas sean más rectangulares
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return PersonTile(person: user);
        },
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final User person;

  const PersonTile({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QSaleImage(
            imgUrlString: person.thumbnail,
            width: 60,
            height: 60,
            borderRadius: 20,
          ),
          const SizedBox(width: 10),
          Text(
            person.username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
