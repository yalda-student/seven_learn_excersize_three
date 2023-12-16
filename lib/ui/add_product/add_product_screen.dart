import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seven_learn_exercise_three/common/di.dart';
import 'package:seven_learn_exercise_three/data/create_product.dart';
import 'package:seven_learn_exercise_three/ui/add_product/bloc/add_product_bloc.dart';
import 'package:seven_learn_exercise_three/ui/widget/app_icon_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var thumbnailUrl = '';
  late final AddProductBloc? productBloc;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const space9 = SizedBox(height: 9);
    const space18 = SizedBox(height: 18);

    var titleTextStyle =
        GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500);

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    var primaryColor = Theme.of(context).colorScheme.primary;

    return BlocProvider<AddProductBloc>(
        lazy: false,
        create: (context) {
          productBloc = AddProductBloc(di.get());
          return productBloc!;
        },
        child: SafeArea(
          child: BlocListener<AddProductBloc, AddProductState>(
            listener: (context, state) {
              if (state is AddProductError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is AddProductSuccess) {
                Navigator.pop(context, state.product);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('New Product'),
                leading: AppIconButton(
                    onTap: () => Navigator.pop(context),
                    icon: const Icon(Icons.keyboard_arrow_left_rounded)),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
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
                      textInputAction: TextInputAction.next,
                    ),
                    space18,
                    Text('Product Thumbnail', style: titleTextStyle),
                    space9,
                    _ProductThumbnail(thumbnailController),
                    const SizedBox(height: 80),
                    Visibility(
                      visible: !keyboardIsOpen,
                      child: GestureDetector(
                        onTap: () {
                          final createProduct = CreateProduct(
                              title: titleController.text,
                              description: descriptionController.text,
                              price: int.tryParse(priceController.text)!,
                              brand: brandController.text,
                              category: categoryController.text,
                              thumbnail: thumbnailController.text);
                          productBloc!.add(AddProduct(product: createProduct));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
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
                              Icon(Icons.add_rounded,
                                  color: primaryColor, size: 30),
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
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _ProductThumbnail extends StatefulWidget {
  const _ProductThumbnail(this.thumbnailController);

  final TextEditingController thumbnailController;

  @override
  State<_ProductThumbnail> createState() => _ProductThumbnailState();
}

class _ProductThumbnailState extends State<_ProductThumbnail> {
  var thumbnailUrl = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.thumbnailController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: 'https://...',
          suffixIcon: Padding(
            padding: const EdgeInsets.all(1),
            child: Image.network(
              thumbnailUrl,
              height: 30,
              width: 30,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          )),
      onChanged: (value) {
        thumbnailUrl = value;
        setState(() {});
      },
    );
  }
}
