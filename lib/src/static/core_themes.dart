import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Themes {
  //Themes

  static final AppTheme defaultLight =
      AppTheme(id: 'default_light', data: lightTheme, description: 'Red (Default)');
  static final AppTheme defaultDark =
      AppTheme(id: 'default_dark', data: darkTheme, description: 'Red (Default)');

  static final List<Color> pride = [
    const Color(0xFFff0000),
    const Color(0xFFff7700),
    const Color(0xFFffdd00),
    const Color(0xFF00ff00),
    const Color(0xFF0000ff),
    const Color(0xFF8b00ff),
  ];

  //Non Default

  //Royal Blue
  static final AppTheme royalBlueDark = AppTheme(
      id: 'royalblue_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF004874),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF004874),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9A72B3),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFF18EC2),
              onTertiary: Colors.white)),
      description: 'Royal Blue');
  static final AppTheme royalBlueLight = AppTheme(
      id: 'royalblue_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF004874),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF004874),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9A72B3),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFF18EC2),
              onTertiary: Colors.white)),
      description: 'Royal Blue');

  //Sky Blue
  static final AppTheme skyBlueDark = AppTheme(
      id: 'skyblue_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF88C0E0),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF88C0E0),
              onPrimary: Colors.white,
              secondary: const Color(0xFF8E77AE),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF93436A),
              onTertiary: Colors.white)),
      description: 'Sky Blue');
  static final AppTheme skyBlueLight = AppTheme(
      id: 'skyblue_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF88C0E0),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF88C0E0),
              onPrimary: Colors.white,
              secondary: const Color(0xFF8E77AE),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF93436A),
              onTertiary: Colors.white)),
      description: 'Sky Blue');

//Turquoise
  static final AppTheme turquoiseDark = AppTheme(
      id: 'turquoise_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF1EADCE),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF1EADCE),
              onPrimary: Colors.white,
              secondary: const Color(0xFF71E6A2),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFA33369),
              onTertiary: Colors.white)),
      description: 'Turquoise');
  static final AppTheme turquoiseLight = AppTheme(
      id: 'turquoise_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF1EADCE),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF1EADCE),
              onPrimary: Colors.white,
              secondary: const Color(0xFF71E6A2),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFA33369),
              onTertiary: Colors.white)),
      description: 'Turquoise');
//Lime
  static final AppTheme limeDark = AppTheme(
      id: 'lime_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF95C11F),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF95C11F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF007F80),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFEDF5CE),
              onTertiary: Colors.black)),
      description: 'Lime');
  static final AppTheme limeLight = AppTheme(
      id: 'lime_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF95C11F),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF95C11F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF007F80),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFEDF5CE),
              onTertiary: Colors.black)),
      description: 'Lime');

//Orange
  static final AppTheme orangeDark = AppTheme(
      id: 'orange_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFF59C00),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFF59C00),
              onPrimary: Colors.white,
              secondary: const Color(0xFF739B00),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF007461),
              onTertiary: Colors.white)),
      description: 'Orange');
  static final AppTheme orangeLight = AppTheme(
      id: 'orange_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFF59C00),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFF59C00),
              onPrimary: Colors.white,
              secondary: const Color(0xFF739B00),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF007461),
              onTertiary: Colors.white)),
      description: 'Orange');
//Pink
  static final AppTheme pinkDark = AppTheme(
      id: 'pink_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFD70277),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFD70277),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFFA147),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF5ABAB5),
              onTertiary: Colors.white)),
      description: 'Pink');
  static final AppTheme pinkLight = AppTheme(
      id: 'pink_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFD70277),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFD70277),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFFA147),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF5ABAB5),
              onTertiary: Colors.white)),
      description: 'Pink');
//Purple
  static final AppTheme purpleDark = AppTheme(
      id: 'purple_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFB27AB3),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFB27AB3),
              onPrimary: Colors.white,
              secondary: const Color(0xFF007FBA),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF00C9C3),
              onTertiary: Colors.white)),
      description: 'Purple');
  static final AppTheme purpleLight = AppTheme(
      id: 'purple_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFB27AB3),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFB27AB3),
              onPrimary: Colors.white,
              secondary: const Color(0xFF007FBA),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF00C9C3),
              onTertiary: Colors.white)),
      description: 'Purple');

//School House
  static final AppTheme scDark = AppTheme(
      id: 'sc_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF0061AC),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF0061AC),
              onPrimary: Colors.white,
              secondary: const Color(0xFFA162BD),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFE1F1FF),
              onTertiary: Colors.black)),
      description: 'School House');
  static final AppTheme scLight = AppTheme(
      id: 'sc_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF0061AC),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF0061AC),
              onPrimary: Colors.white,
              secondary: const Color(0xFFA162BD),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFE1F1FF),
              onTertiary: Colors.black)),
      description: 'School House');

//Judde House
  static final AppTheme jhDark = AppTheme(
      id: 'jh_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFAC2786),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFAC2786),
              onPrimary: Colors.white,
              secondary: const Color(0xFF009AB2),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFE5FE),
              onTertiary: Colors.black)),
      description: 'Judde House');
  static final AppTheme jhLight = AppTheme(
      id: 'jh_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFAC2786),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFAC2786),
              onPrimary: Colors.white,
              secondary: const Color(0xFF009AB2),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFE5FE),
              onTertiary: Colors.black)),
      description: 'Judde House');

//Park House
  static final AppTheme phDark = AppTheme(
      id: 'ph_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF56227D),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF56227D),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFE8057),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF00C9B1),
              onTertiary: Colors.black)),
      description: 'Park House');
  static final AppTheme phLight = AppTheme(
      id: 'ph_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF56227D),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF56227D),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFE8057),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF00C9B1),
              onTertiary: Colors.black)),
      description: 'Park House');

//Hill Side
  static final AppTheme hsDark = AppTheme(
      id: 'hs_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFD0383F),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFD0383F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF8B64C7),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF74B2DF),
              onTertiary: Colors.black)),
      description: 'Hill Side');
  static final AppTheme hsLight = AppTheme(
      id: 'hs_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFD0383F),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFD0383F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF8B64C7),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF74B2DF),
              onTertiary: Colors.black)),
      description: 'Hill Side');

//Parkside
  static final AppTheme psDark = AppTheme(
      id: 'ps_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF0175BF),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF0175BF),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFFD300),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFCE4B99),
              onTertiary: Colors.white)),
      description: 'Parkside');
  static final AppTheme psLight = AppTheme(
      id: 'ps_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF0175BF),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF0175BF),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFFD300),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFCE4B99),
              onTertiary: Colors.white)),
      description: 'Parkside');

//Ferox Hall
  static final AppTheme fhDark = AppTheme(
      id: 'fh_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFEC952C),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFEC952C),
              onPrimary: Colors.white,
              secondary: const Color(0xFF008049),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFEE00),
              onTertiary: Colors.black)),
      description: 'Ferox Hall');
  static final AppTheme fhLight = AppTheme(
      id: 'fh_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFEC952C),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFEC952C),
              onPrimary: Colors.white,
              secondary: const Color(0xFF008049),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFEE00),
              onTertiary: Colors.black)),
      description: 'Ferox Hall');

//Manor House
  static final AppTheme mhDark = AppTheme(
      id: 'mh_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFD0383F),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFD0383F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF005F2F),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF74B2DF),
              onTertiary: Colors.white)),
      description: 'Manor House');
  static final AppTheme mhLight = AppTheme(
      id: 'mh_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFD0383F),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFD0383F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF005F2F),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF74B2DF),
              onTertiary: Colors.white)),
      description: 'Manor House');

//Welldon House
  static final AppTheme whDark = AppTheme(
      id: 'wh_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFD7EDF2),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFD7EDF2),
              onPrimary: Colors.black,
              secondary: const Color(0xFF968FAD),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFBFFBFF),
              onTertiary: Colors.black)),
      description: 'Welldon House');
  static final AppTheme whLight = AppTheme(
      id: 'wh_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF0F212D),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF0F212D),
              onPrimary: Colors.white,
              secondary: const Color(0xFF887797),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFF1B6D0),
              onTertiary: Colors.white)),
      description: 'Welldon House');

//Smythe House
  static final AppTheme shDark = AppTheme(
      id: 'sh_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFC61672),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFC61672),
              onPrimary: Colors.white,
              secondary: const Color(0xFF009D97),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFE3F4),
              onTertiary: Colors.black)),
      description: 'Smythe House');
  static final AppTheme shLight = AppTheme(
      id: 'sh_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFC61672),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFC61672),
              onPrimary: Colors.white,
              secondary: const Color(0xFF563217),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFE3F4),
              onTertiary: Colors.black)),
      description: 'Smythe House');

//Whitworth
  static final AppTheme wwDark = AppTheme(
      id: 'ww_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF016B37),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF016B37),
              onPrimary: Colors.white,
              secondary: const Color(0xFFE1E1DB),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFD4FADD),
              onTertiary: Colors.black)),
      description: 'Whitworth');
  static final AppTheme wwLight = AppTheme(
      id: 'ww_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF016B37),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF016B37),
              onPrimary: Colors.white,
              secondary: const Color(0xFF00ACB6),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF009DD3),
              onTertiary: Colors.white)),
      description: 'Whitworth');

  //Cowdrey House
  static final AppTheme chDark = AppTheme(
      id: 'ch_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF005F2F),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF005F2F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9F579E),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF00B7BC),
              onTertiary: Colors.white)),
      description: 'Cowdrey House');
  static final AppTheme chLight = AppTheme(
      id: 'ch_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF005F2F),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF005F2F),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9F579E),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF00B7BC),
              onTertiary: Colors.white)),
      description: 'Cowdrey House');

  //Oakeshott House
  static final AppTheme ohDark = AppTheme(
      id: 'oh_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF8D0339),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF8D0339),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFBBA01),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFE3EA),
              onTertiary: Colors.black)),
      description: 'Oakeshott House');
  static final AppTheme ohLight = AppTheme(
      id: 'oh_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF8D0339),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF8D0339),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFBBA01),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFE3EA),
              onTertiary: Colors.black)),
      description: 'Oakeshott House');

  //Watermelon
  static final AppTheme watermelonDark = AppTheme(
      id: 'watermelon_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFFE7F9C),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFFE7F9C),
              onPrimary: Colors.white,
              secondary: const Color(0xFF72B254),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFF4E2E4),
              onTertiary: Colors.black)),
      description: 'Watermelon');
  static final AppTheme watermelonLight = AppTheme(
      id: 'watermelon_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFFE7F9C),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFFE7F9C),
              onPrimary: Colors.white,
              secondary: const Color(0xFF72B254),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF260F11),
              onTertiary: Colors.white)),
      description: 'Watermelon');

  //Coral
  static final AppTheme coralDark = AppTheme(
      id: 'coral_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFFD7D68),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFFD7D68),
              onPrimary: Colors.white,
              secondary: const Color(0xFF005C6F),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFBEFCFF),
              onTertiary: Colors.black)),
      description: 'Coral');
  static final AppTheme coralLight = AppTheme(
      id: 'coral_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFFD7D68),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFFD7D68),
              onPrimary: Colors.white,
              secondary: const Color(0xFF005C6F),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFBEFCFF),
              onTertiary: Colors.black)),
      description: 'Coral');
  //Aegean
  static final AppTheme aegeanDark = AppTheme(
      id: 'aegean_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF1D456E),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF1D456E),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9A73AE),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFDCA11D),
              onTertiary: Colors.white)),
      description: 'Aegean');
  static final AppTheme aegeanLight = AppTheme(
      id: 'aegean_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF1D456E),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF1D456E),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9A73AE),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFDCA11D),
              onTertiary: Colors.white)),
      description: 'Aegean');

  //Teal
  static final AppTheme tealDark = AppTheme(
      id: 'teal_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF48AAAB),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF48AAAB),
              onPrimary: Colors.white,
              secondary: const Color(0xFF9A73AE),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF9199CD),
              onTertiary: Colors.white)),
      description: 'Teal');
  static final AppTheme tealLight = AppTheme(
      id: 'teal_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF48AAAB),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF48AAAB),
              onPrimary: Colors.white,
              secondary: const Color(0xFF8A1D00),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF9199CD),
              onTertiary: Colors.white)),
      description: 'Teal');

//Teal
  static final AppTheme orchidDark = AppTheme(
      id: 'orchid_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFAF69ED),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFAF69ED),
              onPrimary: Colors.white,
              secondary: const Color(0x0fee5830),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFEE9FF),
              onTertiary: Colors.black)),
      description: 'Orchid');
  static final AppTheme orchidLight = AppTheme(
      id: 'orchid_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFAF69ED),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFAF69ED),
              onPrimary: Colors.white,
              secondary: const Color(0xFFEE5830),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFEE9FF),
              onTertiary: Colors.black)),
      description: 'Orchid');

  //Basil
  static final AppTheme basilDark = AppTheme(
      id: 'basil_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF33612E),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF33612E),
              onPrimary: Colors.white,
              secondary: const Color(0xFF00B7FF),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFDDF8D7),
              onTertiary: Colors.black)),
      description: 'Basil');
  static final AppTheme basilLight = AppTheme(
      id: 'basil_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF33612E),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF33612E),
              onPrimary: Colors.white,
              secondary: const Color(0xFF00B7FF),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFDDF8D7),
              onTertiary: Colors.black)),
      description: 'Basil');
//Basil
  static final AppTheme fernDark = AppTheme(
      id: 'fern_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF5DBC63),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF5DBC63),
              onPrimary: Colors.white,
              secondary: const Color(0xFF008EB2),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFDEF2FF),
              onTertiary: Colors.black)),
      description: 'Fern');
  static final AppTheme fernLight = AppTheme(
      id: 'fern_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF5DBC63),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF5DBC63),
              onPrimary: Colors.white,
              secondary: const Color(0xFF008EB2),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFDEF2FF),
              onTertiary: Colors.black)),
      description: 'Fern');

//Spring Green
  static final AppTheme springGreenDark = AppTheme(
      id: 'springgreen_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF41F99B),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF41F99B),
              onPrimary: Colors.black,
              secondary: const Color(0xFF8BB5FF),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFA713),
              onTertiary: Colors.black)),
      description: 'Spring Green');
  static final AppTheme springGreenLight = AppTheme(
      id: 'springgreen_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF41F99B),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF41F99B),
              onPrimary: Colors.black,
              secondary: const Color(0xFF8BB5FF),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFA713),
              onTertiary: Colors.white)),
      description: 'Spring Green');
//Latte
  static final AppTheme latteDark = AppTheme(
      id: 'latte_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFE8C07A),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFE8C07A),
              onPrimary: Colors.black,
              secondary: const Color(0xFFC1554D),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFC1B3),
              onTertiary: Colors.black)),
      description: 'Latte');
  static final AppTheme latteLight = AppTheme(
      id: 'latte_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFE8C07A),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFE8C07A),
              onPrimary: Colors.black,
              secondary: const Color(0xFFC1554D),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFFFC1B3),
              onTertiary: Colors.black)),
      description: 'Latte');
  //Scarlet
  static final AppTheme scarletDark = AppTheme(
      id: 'scarlet_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF920D09),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF920D09),
              onPrimary: Colors.white,
              secondary: const Color(0xFF005D3D),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF64239F),
              onTertiary: Colors.white)),
      description: 'Scarlet');
  static final AppTheme scarletLight = AppTheme(
      id: 'scarlet_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF920D09),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF920D09),
              onPrimary: Colors.white,
              secondary: const Color(0xFF005D3D),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF64239F),
              onTertiary: Colors.white)),
      description: 'Scarlet');

  //Technicolor
  static final AppTheme technicolorDark = AppTheme(
      id: 'technicolor_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFFFADAC),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFFFADAC),
              onPrimary: Colors.white,
              secondary: const Color(0xFFE4F1EE),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFDEDAF4),
              onTertiary: Colors.black)),
      description: 'Technicolor');
  static final AppTheme technicolorLight = AppTheme(
      id: 'technicolor_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFFFADAC),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFFFADAC),
              onPrimary: Colors.black,
              secondary: const Color(0xFFE4F1EE),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFDEDAF4),
              onTertiary: Colors.black)),
      description: 'Technicolor');

  //90s Kid
  static final AppTheme kid90Dark = AppTheme(
      id: 'kid90_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF98ECF1),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF98ECF1),
              onPrimary: Colors.black,
              secondary: const Color(0xFFBDB2FF),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFFEC868),
              onTertiary: Colors.black)),
      description: '90s Kid');
  static final AppTheme kid90Light = AppTheme(
      id: 'kid90_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF98ECF1),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF98ECF1),
              onPrimary: Colors.black,
              secondary: const Color(0xFFBDB2FF),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFFEC868),
              onTertiary: Colors.black)),
      description: '90s Kid');
  //Rubber Duck
  static final AppTheme rubberDuckDark = AppTheme(
      id: 'rubberduck_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFF6B975),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFF6B975),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFCFDAF),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFF8DC5C),
              onTertiary: Colors.black)),
      description: 'Rubber Duck');
  static final AppTheme rubberDuckLight = AppTheme(
      id: 'rubberduck_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFF6B975),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFF6B975),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFCFDAF),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFF8DC5C),
              onTertiary: Colors.black)),
      description: 'Rubber Duck');
  //Waterfall
  static final AppTheme waterfallDark = AppTheme(
      id: 'waterfall_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFFE5F8F8),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFFE5F8F8),
              onPrimary: Colors.black,
              secondary: const Color(0xFFA8CAD6),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFD5E3E4),
              onTertiary: Colors.black)),
      description: 'Waterfall');
  static final AppTheme waterfallLight = AppTheme(
      id: 'waterfall_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFFE5F8F8),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFE5F8F8),
              onPrimary: Colors.black,
              secondary: const Color(0xFFA8CAD6),
              onSecondary: Colors.black,
              tertiary: const Color(0xFFD5E3E4),
              onTertiary: Colors.black)),
      description: 'Waterfall');

  static final AppTheme itdDark = AppTheme(
      id: 'itd_dark',
      data: darkTheme.copyWith(
          primaryColor: const Color(0xFF234AB8),
          colorScheme: darkTheme.colorScheme.copyWith(
              primary: const Color(0xFF234AB8),
              onPrimary: Colors.white,
              secondary: const Color(0xFFC54091),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFC54091),
              onTertiary: Colors.white)),
      description: 'IT & Digital');
  static final AppTheme itdLight = AppTheme(
      id: 'itd_light',
      data: lightTheme.copyWith(
          primaryColor: const Color(0xFF234AB8),
          colorScheme: lightTheme.colorScheme.copyWith(
              primary: const Color(0xFF234AB8),
              onPrimary: Colors.white,
              secondary: const Color(0xFFC54091),
              onSecondary: Colors.white,
              tertiary: const Color(0xFFC54091),
              onTertiary: Colors.white)),
      description: 'IT & Digital');

  //Black/White
  static final AppTheme whiteThemeLight = AppTheme(
      id: 'white_light',
      description: 'white/black',
      data: ThemeData(
          fontFamily: 'Cairo',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
          dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          //dialogTheme: const DialogTheme(backgroundColor: Colors.white),
          timePickerTheme: const TimePickerThemeData(
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.white,
              ),
              hourMinuteColor: Colors.white),
          colorScheme: const ColorScheme.light().copyWith(
            surfaceContainer: Colors.white,
            brightness: Brightness.light,
            primary: Colors.black,
            surfaceTint: Colors.white,
            onPrimary: Colors.white,
            secondary: Colors.black,
            onSecondary: Colors.white,
            tertiary: Colors.white,
            onTertiary: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          )));
  static final AppTheme whiteThemeDark = AppTheme(
      id: 'white_dark',
      description: 'black/white',
      data: ThemeData(
          fontFamily: 'Cairo',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          popupMenuTheme: const PopupMenuThemeData(color: Colors.black),
          dialogTheme: const DialogThemeData(backgroundColor: Colors.black),
          timePickerTheme: const TimePickerThemeData(
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.black,
              ),
              hourMinuteColor: Colors.black),
          colorScheme: const ColorScheme.light().copyWith(
            surfaceContainer: Colors.black,
            brightness: Brightness.light,
            primary: Colors.white,
            surfaceTint: Colors.black,
            onPrimary: Colors.black,
            secondary: Colors.white,
            onSecondary: Colors.black,
            tertiary: Colors.black,
            onTertiary: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          )));

  static final AppTheme whiteBlackThemeDark = AppTheme(
      id: 'whiteblack_dark',
      description: 'white/black',
      data: ThemeData(
          fontFamily: 'Cairo',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
          dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          timePickerTheme: const TimePickerThemeData(
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.white,
              ),
              hourMinuteColor: Colors.white),
          colorScheme: const ColorScheme.light().copyWith(
            surfaceContainer: Colors.white,
            brightness: Brightness.light,
            primary: Colors.black,
            surfaceTint: Colors.white,
            onPrimary: Colors.white,
            secondary: Colors.black,
            onSecondary: Colors.white,
            tertiary: Colors.white,
            onTertiary: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          )));
  static final AppTheme whiteBlackThemeLight = AppTheme(
      id: 'whiteblack_light',
      description: 'black/white',
      data: ThemeData(
          fontFamily: 'Cairo',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          popupMenuTheme: const PopupMenuThemeData(color: Colors.black),
          dialogTheme: const DialogThemeData(backgroundColor: Colors.black),
          timePickerTheme: const TimePickerThemeData(
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.black,
              ),
              hourMinuteColor: Colors.black),
          colorScheme: const ColorScheme.light().copyWith(
            surfaceContainer: Colors.black,
            brightness: Brightness.light,
            primary: Colors.white,
            surfaceTint: Colors.black,
            onPrimary: Colors.black,
            secondary: Colors.white,
            onSecondary: Colors.black,
            tertiary: Colors.black,
            onTertiary: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          )));

  //ThemeList

  static final List<AppTheme> themes = [
    defaultLight,
    defaultDark,
    skyBlueDark,
    skyBlueLight,
    royalBlueDark,
    royalBlueLight,
    turquoiseDark,
    turquoiseLight,
    limeDark,
    limeLight,
    orangeDark,
    orangeLight,
    pinkDark,
    pinkLight,
    purpleDark,
    purpleLight,
    scDark,
    scLight,
    jhDark,
    jhLight,
    phDark,
    phLight,
    hsDark,
    hsLight,
    psDark,
    psLight,
    fhDark,
    fhLight,
    mhDark,
    mhLight,
    whDark,
    whLight,
    shDark,
    shLight,
    wwDark,
    wwLight,
    chDark,
    chLight,
    ohDark,
    ohLight,
    watermelonDark,
    watermelonLight,
    coralDark,
    coralLight,
    aegeanDark,
    aegeanLight,
    tealDark,
    tealLight,
    orchidDark,
    orchidLight,
    basilDark,
    basilLight,
    fernDark,
    fernLight,
    springGreenDark,
    springGreenLight,
    latteDark,
    latteLight,
    scarletDark,
    scarletLight,
    technicolorDark,
    technicolorLight,
    kid90Dark,
    kid90Light,
    rubberDuckDark,
    rubberDuckLight,
    waterfallDark,
    waterfallLight,
    itdDark,
    itdLight,
    whiteThemeLight,
    whiteThemeDark,
    whiteBlackThemeLight,
    whiteBlackThemeDark
  ];

  static List<AppTheme> getThemes() {
    return PlatformDispatcher.instance.platformBrightness == Brightness.dark
        ? themes.where((element) => element.id.endsWith('_dark')).toList()
        : themes.where((element) => element.id.endsWith('_light')).toList();
  }

  //ThemeData

  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'Cairo',
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color.fromARGB(255, 226, 232, 240),
      primaryColor: const Color(0xFFDB3034),
      popupMenuTheme: const PopupMenuThemeData(color: Color.fromARGB(255, 226, 232, 240)),
      dialogTheme: const DialogThemeData(backgroundColor: Color.fromARGB(255, 226, 232, 240)),
      timePickerTheme: const TimePickerThemeData(
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Color.fromARGB(255, 226, 232, 240),
          ),
          hourMinuteColor: Color.fromARGB(255, 226, 232, 240)),
      colorScheme: const ColorScheme.light().copyWith(
        surfaceContainer: const Color.fromARGB(255, 226, 232, 240),
        brightness: Brightness.light,
        primary: const Color(0xFFDB3034),
        surfaceTint: const Color.fromARGB(255, 226, 232, 240),
        onPrimary: Colors.white,
        secondary: const Color(0xFFB050BB),
        onSecondary: Colors.white,
        tertiary: const Color(0xFF94ABE0),
        onTertiary: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ));

  static final ThemeData darkTheme = ThemeData(
      fontFamily: 'Cairo',
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFDB3034),
      scaffoldBackgroundColor: const Color.fromARGB(255, 30, 41, 59),
      popupMenuTheme: const PopupMenuThemeData(color: Color.fromARGB(255, 30, 41, 59)),
      dialogTheme: const DialogThemeData(backgroundColor: Color.fromARGB(255, 30, 41, 59)),
      timePickerTheme: const TimePickerThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color.fromARGB(255, 30, 41, 59),
        ),
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        surfaceContainer: const Color.fromARGB(255, 30, 41, 59),
        brightness: Brightness.dark,
        surfaceTint: const Color.fromARGB(255, 30, 41, 59),
        primary: const Color(0xFFDB3034),
        onPrimary: Colors.white,
        secondary: const Color(0xFFB050BB),
        onSecondary: Colors.white,
        tertiary: const Color(0xFF94ABE0),
        onTertiary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
      ));
}
