import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

class Brands extends StatefulWidget {
  String init;

  Brands({this.init});

  @override
  State<StatefulWidget> createState() {
    return BrandsState(init: init);
  }
}

class BrandsState extends State<Brands> {
  String init;

  BrandsState({this.init});

  var _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _typeAheadController.text = init;

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        // focusNode: brandsNode,
        style: TextStyle(
          fontFamily: FontFamilies.POPPINS,
          fontSize: (MediaQuery.of(context).size.height * 0.02),
          color: Colors.black,
        ),
        controller: _typeAheadController,
        decoration: InputDecoration(
          // hintText: captainPersonalData!=null?captainPersonalData.data.car.carBrandName:" ",
          contentPadding: EdgeInsets.all(0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.MAIN_COLOR),
          ),
          labelText: 'Vehicle Make',
          labelStyle: TextStyle(
            color: AppColors.labelColor,
            fontFamily: FontFamilies.POPPINS,
            fontSize: (MediaQuery.of(context).size.height * 0.02),
          ),
        ),
      ),
      itemBuilder: (BuildContext context, suggestion) {
        return ListTile(
          title: Text(
            suggestion,
            style: TextStyle(
              fontFamily: FontFamilies.POPPINS,
              fontSize: (MediaQuery.of(context).size.height * 0.02),
              color: AppColors.labelColor,
            ),
          ),
        );
      },
      suggestionsCallback: (String pattern) {
        return vehicleBloc.getSuggestions(pattern);
      },
      onSuggestionSelected: (suggestion) {
        setState(() {
          init = suggestion;
          _typeAheadController.text = suggestion;
        });
        vehicleBloc.setCarBrand(suggestion.toString());


        // vehicleBloc.getSuggestions("a");
      },
      hideOnError: true,
      onSaved: (suggestion) {
        setState(() {
          _typeAheadController.text = suggestion;
          // vehicleBloc.setCarBrand(suggestion.toString());

        });
        // vehicleBloc.getSuggestions(null);
      },
    );
  }
}