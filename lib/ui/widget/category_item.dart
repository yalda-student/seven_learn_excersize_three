import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 6),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffCBF9FF).withOpacity(.46)),
      child: Text(
        title,
        style: GoogleFonts.montserrat(fontSize: 13),
      ),
    );
  }
}
