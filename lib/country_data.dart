import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' hide BuildContext;

import 'main.dart';

class CountryData extends ChangeNotifier{

  Country selectedCountry = CountryPickerUtils.getCountryByName('Nigeria');

  CountryData(){
    this.selectedCountry;
  }

  void setCountry(Country country){
    this.selectedCountry =  country;
    notifyListeners();
  }

  Country getCountry() {
    return selectedCountry;
  }



  String getPhoneCode(){
    return selectedCountry.phoneCode.toString();
  }

  String getIso(){
    return selectedCountry.isoCode;
  }

  Widget getCountryName() {
    return Text(selectedCountry.name);
  }

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      SizedBox(width: 8.0),
      Flexible(child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 8.0),
        child: Text(country.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ))
    ],
  );

  void openCountryPickerDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Container(
      color: Colors.white.withOpacity(0.70),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: primaryRedDark),
        child: CountryPickerDialog(
          contentPadding: EdgeInsets.only(bottom: 30.0, left: 0.0, right: 0.0),
          searchCursorColor: primaryRed,
          searchInputDecoration: InputDecoration(hintText: 'Search...',
          ),
          isSearchable: true,
          title: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Tap to change country',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  HorizontalLine(width: 160.0, height: 2.5, color: primaryRed,),
                ],
              ),
              iconButton(icon: Icons.refresh, function: null, color: Colors.black,),
              iconButton(icon: Icons.close, color: Colors.black, function: (){Navigator.pop(context);},),

            ],
          ),
          onValuePicked: (Country country) {
            selectedCountry = country;
            Provider.of<CountryData>(context, listen: false).setCountry(selectedCountry);
          },

          itemBuilder: _buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('NG'),
            CountryPickerUtils.getCountryByIsoCode('SA'),
          ],
        ),
      ),
    ),
  );
}