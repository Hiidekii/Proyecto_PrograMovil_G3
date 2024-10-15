import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/events/components/search_bar.dart'
    as custom;

class PeopleSection extends StatelessWidget {
  final List<Person> filteredPeople;
  final TextEditingController searchController;
  final Function(String) onSearch;
  final Function(BuildContext) onAddPerson;

  const PeopleSection({
    Key? key,
    required this.filteredPeople,
    required this.searchController,
    required this.onSearch,
    required this.onAddPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: custom.SearchBar(
                  controller: searchController,
                  onChanged: onSearch,
                  hintText: 'Buscar',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                  onPressed: () => onAddPerson(context),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredPeople.length,
            itemBuilder: (context, index) {
              return PersonTile(person: filteredPeople[index]);
            },
          ),
        ),
      ],
    );
  }
}

class Person {
  final String name;
  final String avatarUrl;

  Person(this.name, this.avatarUrl);
}

class PersonTile extends StatelessWidget {
  final Person person;

  const PersonTile({Key? key, required this.person}) : super(key: key);

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
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: AssetImage(person.avatarUrl),
            radius: 25,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              person.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
