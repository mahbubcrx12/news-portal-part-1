import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double? fs,Color? clr,[FontWeight? fw]){
  return GoogleFonts.roboto(
    fontSize: fs,
    color: clr,
    fontWeight: fw
  );
}

String apiKey="503143c1974d402b8c7f7f9f3d2fd7a3";
String baseUrl="https://newsapi.org";