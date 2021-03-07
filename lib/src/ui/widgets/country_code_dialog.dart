import 'package:country_provider/country_provider.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/models/country_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

import 'package:country_codes/country_codes.dart';

class CountryCodeDialog extends StatelessWidget {
  String screen;
  CountryCodeDialog({this.screen});
  String currentCountryCode = "";
  CountryDetails countryDetails = CountryCodes.detailsForLocale();



  @override
  Widget build(BuildContext context) {

    return Container(
      height: 270,

      child:Dialog(
      child:Container(
        height: 270,


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:EdgeInsets.all(10),
              child:  Text("Select Country", style: TextStyle(
                  fontFamily: FontFamilies.POPPINS,
                  fontSize: (MediaQuery.of(context).size.height * 0.02)+2),),

            ),

            Divider(
              thickness: 0.7,
              color: AppColors.LIGHT_GREY,
            ),
            StreamBuilder(
              stream: countryBloc.country,
              builder: (BuildContext context, AsyncSnapshot<CountryModel> snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, position) {
                    return container(context, snapshot.data, position);
                  },
                  itemCount: snapshot.data.data.data.length,
                );
              },
            )],
        ),
      ),

      ),



    );
  }

  container(context, CountryModel countryModel, int index) {
    String code;
    return InkWell(
      onTap: (){
        countryBloc.getCities(countryModel.data.data[index].countryCode);
        Navigator.pop(context);
        if( screen=="SIGN_UP")
          {phoneBloc.setCountryCode(countryBloc.getCountryDetails(index), countryModel.data.data[index].countryCode);}
        if( screen=="FORGOT_PASS")
 {          forgotPassBloc.setCountryCode(countryBloc.getCountryDetails(index), countryModel.data.data[index].countryCode);
 }
         else
          {
            signInBloc.setCountryCode(countryBloc.getCountryDetails(index), countryModel.data.data[index].countryCode);


          }
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              child: Row(
                children: [
                  Container(
                    padding:EdgeInsets.only(left:10,right: 10),
                    child: Flag(
                      countryModel.data.data[index].countryCode,
                      width: 50,
                      height: 50,
                    ),
                  ),

                  Text(countryModel.data.data[index].nameEG,        style: TextStyle(
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery.of(context).size.height * 0.02)+1),),
                ],
              ),
            ),
            Container(
              padding:EdgeInsets.only(left:10,right: 10),
              child:    StreamBuilder(
                stream: countryBloc.countryDetails,
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if(snapshot.hasData){
                    code=snapshot.data[index];
                    return  Text("+"+snapshot.data[index],  style: TextStyle(
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.height * 0.02)),);}
                  else
                  {return Container();}
                },
              ),
            ),



          ],
        ),
      ),
    )
      ;
  }


}
