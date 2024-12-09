import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hey_taxi_app/src/data/api/api_config.dart';


class PleacesAutocompleteTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(Prediction)? onPlaceSelected;
  final IconData? icon;
  final FocusNode? focusNode; // NUEVO

  const PleacesAutocompleteTextfield({
    super.key,
    required this.controller,
    required this.onPlaceSelected,
    this.icon,
    required this.label,
    this.focusNode, // NUEVO
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.060,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GooglePlaceAutoCompleteTextField(
        textStyle: const TextStyle( color: Colors.white),
        textEditingController: controller,
        googleAPIKey: ApiConfig.API_GOOGLE_MAPS,
        debounceTime: 1000,
        focusNode: focusNode, // ASIGNAMOS EL FOCUS NODE
        boxDecoration: BoxDecoration(
          color:const Color.fromARGB(255, 44, 47, 55),
          borderRadius: BorderRadius.circular(10),
        ),
        inputDecoration: InputDecoration(

          icon: const Icon(Icons.location_on, color: Colors.white),
          label: Text(label, style: const TextStyle(fontSize: 20, color: Colors.white30)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          // contentPadding: EdgeInsets.only( left: 10)
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
