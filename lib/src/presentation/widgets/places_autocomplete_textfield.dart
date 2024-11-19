import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hey_taxi_app/src/data/api/api_config.dart';

class PleacesAutocompleteTextfield extends StatelessWidget {
  final TextEditingController controller;
  // final String hintText;
  final String label;
  final Function(Prediction)? onPlaceSelected;
  final IconData? icon;

  const PleacesAutocompleteTextfield({super.key, required this.controller, required this.onPlaceSelected, this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.of(context).size.height * 0.054,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: ApiConfig.API_GOOGLE_MAPS,
        debounceTime: 1000, 
        boxDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        inputDecoration: InputDecoration(
          // hintText: hintText,
          label: Text( label,  style:  const TextStyle( color: Colors.black54)),
          // prefixIcon: Icon(icon, color: Colors.amber,),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          //  focusedBorder: const UnderlineInputBorder(
          //  borderSide: BorderSide(color: Colors.black26),
          // )
        ),
        countries: const ["co"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: onPlaceSelected,
        itemClick: (Prediction prediction) {
          if (prediction.description != null) {
            controller.text = prediction.description!;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length),
            );
          }
        },
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 7),
                Expanded(child: Text(prediction.description ?? "")),
              ],
            ),
          );
        },
        isCrossBtnShown: true,
      ),
    );
  }
}
