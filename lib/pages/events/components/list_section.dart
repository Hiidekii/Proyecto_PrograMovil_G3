import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/events/components/search_bar.dart'
    as custom;

class ListSection extends StatelessWidget {
  final List<Lista> filteredListas;
  final TextEditingController searchController;
  final Function(String) onSearch;
  final Map<String, List<Map<String, dynamic>>> categoryItems;

  const ListSection({
    Key? key,
    required this.filteredListas,
    required this.searchController,
    required this.onSearch,
    required this.categoryItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: custom.SearchBar(
            controller: searchController,
            onChanged: onSearch,
            hintText: 'Buscar listas',
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredListas.length,
            itemBuilder: (context, index) {
              return ListTile(
                lista: filteredListas[index],
                categoryItems: categoryItems,
              );
            },
          ),
        ),
      ],
    );
  }
}

class Lista {
  final String category;
  final String name;
  final int totalQuantity;
  bool isExpanded = false;

  Lista(this.category, this.name, this.totalQuantity);
}

class ListTile extends StatelessWidget {
  final Lista lista;
  final Map<String, List<Map<String, dynamic>>> categoryItems;

  const ListTile({
    Key? key,
    required this.lista,
    required this.categoryItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String title;

    if (lista.category == "Dinero") {
      icon = Icons.monetization_on;
      title = "La chancha";
    } else if (lista.category == "Bebida") {
      icon = Icons.local_bar;
      title = "El trago";
    } else if (lista.category == "Comida") {
      icon = Icons.fastfood;
      title = "La bajona";
    } else {
      icon = Icons.category;
      title = "Sin categoría";
    }

    List<Widget> listItems = [];

    if (categoryItems.containsKey(lista.category)) {
      for (var item in categoryItems[lista.category]!) {
        listItems.add(ListItemWidget(
          name: item['name'],
          quantity: item['quantity'],
          status: item['status'],
          userImgUrl: item['userImgUrl'],
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 10.0, bottom: 10.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.softBlack
                : AppColors.darkBackgroundColor,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 25,
                    child: Icon(
                      icon,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lista.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Expanded(child: SizedBox(width: 15)),
                        IconButton(
                          icon: Icon(
                            lista.isExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // You might need to use a StatefulBuilder or lift the state up
                            // to handle this toggle if it's not updating the UI
                            lista.isExpanded = !lista.isExpanded;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (lista.isExpanded) ...listItems,
              if (lista.category == "Dinero") MoneyInputWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String name;
  final String quantity;
  final String status;
  final String userImgUrl;

  const ListItemWidget({
    Key? key,
    required this.name,
    required this.quantity,
    required this.status,
    required this.userImgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconStatus;
    Color iconStatusColor;

    if (status == "Done") {
      iconStatus = Icons.check_circle_outline_rounded;
      iconStatusColor = Color.fromRGBO(95, 189, 110, 1);
    } else {
      iconStatus = Icons.access_time_rounded;
      iconStatusColor = Color.fromRGBO(30, 186, 255, 1);
    }

    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 4, left: 8.0, right: 20),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 25,
            backgroundImage: AssetImage(userImgUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B8254),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    '$quantity/5',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  iconStatus,
                  size: 25,
                  color: iconStatusColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoneyInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 4, left: 20.0, right: 20),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Monto",
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(left: 8, right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 50),
          ElevatedButton(
            onPressed: () {
              // Add your button action here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF6B630),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on),
                const SizedBox(width: 2),
                const Text("Aportar"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
