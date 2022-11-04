import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

// colors
const Color whiteColor70 = Color(0xB3FFFFFF);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kPrimary = Color(0xFF629C59);
const Color kSecondary = Color(0xFF86B537);
const Color kTertiary = Color(0xFF9AC850);
const Color kTextColor = Color(0xFF1D232E);
const Color kSecondaryTextColor = Color(0xFF629C59);
const Color kTertiaryTextColor = Colors.white;
const Color kTaskTile = Color.fromARGB(255, 236, 236, 236);
const Color kHint = Colors.grey;

// text style
final TextStyle kHeading1 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kHeading2 = GoogleFonts.roboto(
  color: kTertiaryTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);
final TextStyle kHeading3 =
    GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400);
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

const kColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: kPrimary,
  onPrimary: Colors.white,
  secondary: kSecondary,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: Colors.white,
  onBackground: kPrimary,
  surface: Colors.black,
  onSurface: kSecondaryTextColor,
);

final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);
