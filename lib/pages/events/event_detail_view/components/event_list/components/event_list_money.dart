import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class AmountInputWidget extends StatelessWidget {
  final void Function(int, double) aportarFunct;
  final int itemID;
  final bool isFloatable;
  final double maxAmount;
  final TextEditingController _amountController = TextEditingController();

  AmountInputWidget({
    super.key,
    required this.itemID,
    required this.aportarFunct,
    required this.isFloatable,
    required this.maxAmount,
  });

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
              controller: _amountController,
              decoration: InputDecoration(
                hintText: "Cant.",
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(left: 8, right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: isFloatable,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 50),
          InkWell(
            onTap: () {
              final amountText = _amountController.text;
              final amount = isFloatable
                  ? double.tryParse(amountText) ?? 0.0
                  : double.tryParse(amountText)?.toInt() ?? 0;

              aportarFunct(itemID, amount.toDouble());
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.yellow,
              ),
              width: 120,
              height: 40,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Aportar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
