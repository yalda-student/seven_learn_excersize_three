import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seven_learn_exercise_three/ui/widget/app_icon_button.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const space9 = SizedBox(height: 9);
    const space18 = SizedBox(height: 18);

    var titleTextStyle =
        GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Product'),
        leading: AppIconButton(
            onTap: () => Navigator.pop(context),
            icon: const Icon(Icons.keyboard_arrow_left_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Name', style: titleTextStyle),
            space9,
            TextField(
              textInputAction: TextInputAction.next,
              controller: titleController,
            ),
            space18,
            Text('Product Price', style: titleTextStyle),
            space9,
            TextField(
              controller: priceController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),
            space18,
            Text('Product Description', style: titleTextStyle),
            space9,
            TextField(
              controller: descriptionController,
              textInputAction: TextInputAction.next,
            ),
            space18,
            Text('Product Brand', style: titleTextStyle),
            space9,
            TextField(
              controller: brandController,
              textInputAction: TextInputAction.next,
            ),
            space18,
            Text('Product Category', style: titleTextStyle),
            space9,
            TextField(
              controller: categoryController,
              textInputAction: TextInputAction.done,
            ),
            space18,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const _AddButton(),
    ));
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 15,
                color: primaryColor.withOpacity(0.25),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: primaryColor, size: 30),
            const SizedBox(width: 4),
            Text(
              'Add',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
