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

class CountryCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CountryState();
  }
}

class CountryState extends State<CountryCode> {
  String flag;
  String countryCode;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 20,
      width: 100,
      child: InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return buildContainer(context);
              });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          width: MediaQuery.of(context).size.width / 3.7,
          height: 50,
          child: Row(
            children: [
              StreamBuilder(
                stream: phoneBloc.countryFlag,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Flag(
                      snapshot.data,
                      width: 45,
                      height: 40,
                    );
                  } else {
                    countryBloc.getCities("JO");
                    return Flag(
                      "JO",
                      width: 45,
                      height: 40,
                    );
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: StreamBuilder(
                      stream: phoneBloc.countryCode,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text("+"+
                            snapshot.data,
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    1),
                          );
                        } else {
                          return Text(
                            "+962",
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    1),
                          );
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: 270,
      child: Dialog(
        child: Container(
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Select Country",
                  style: TextStyle(
                      fontFamily: FontFamilies.POPPINS,
                      fontSize:
                          (MediaQuery.of(context).size.height * 0.02) + 2),
                ),
              ),
              Divider(
                thickness: 0.7,
                color: AppColors.LIGHT_GREY,
              ),
              StreamBuilder(
                stream: countryBloc.country,
                builder: (BuildContext context,
                    AsyncSnapshot<CountryModel> snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return container(context, snapshot.data, position);
                    },
                    itemCount: snapshot.data.data.data.length,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  container(context, CountryModel countryModel, int index) {
    String code;

    return InkWell(
      onTap: () {
        countryBloc.getCities(countryModel.data.data[index].countryCode);
        Navigator.pop(context);

        setState(() {
          countryCode = "+" + countryBloc.getCountryDetails(index);
          flag = countryModel.data.data[index].countryCode;
        });

        signInBloc.setCountryCode(countryBloc.getCountryDetails(index),
            countryModel.data.data[index].countryCode);
        phoneBloc.setCountryCode(countryBloc.getCountryDetails(index),
            countryModel.data.data[index].countryCode);
        forgotPassBloc.setCountryCode(countryBloc.getCountryDetails(index),
            countryModel.data.data[index].countryCode);
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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Flag(
                      countryModel.data.data[index].countryCode,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text(
                    countryModel.data.data[index].nameEG,
                    style: TextStyle(
                        fontFamily: FontFamilies.POPPINS,
                        fontSize:
                            (MediaQuery.of(context).size.height * 0.02) + 1),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: StreamBuilder(
                stream: countryBloc.countryDetails,
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    code = snapshot.data[index];
                    return Text(
                      "+" + snapshot.data[index],
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                              (MediaQuery.of(context).size.height * 0.02)),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
