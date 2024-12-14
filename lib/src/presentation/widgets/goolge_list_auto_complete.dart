import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:dio/dio.dart';

class GooglePlaceAutoCompleteList extends StatefulWidget {
  final String googleAPIKey;
  final TextEditingController textEditingController;
  final Function(Prediction)? onItemClick;
  final String language;

  const GooglePlaceAutoCompleteList({
    super.key,
    required this.googleAPIKey,
    required this.textEditingController,
    this.onItemClick,
    this.language = 'en',
  });

  @override
  _GooglePlaceAutoCompleteListState createState() =>
      _GooglePlaceAutoCompleteListState();
}

class _GooglePlaceAutoCompleteListState
    extends State<GooglePlaceAutoCompleteList> {
  List<Prediction> predictions = [];

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.textEditingController.text;
    if (text.isNotEmpty) {
      _fetchPredictions(text);
    } else {
      setState(() {
        predictions.clear();
      });
    }
  }

  Future<void> _fetchPredictions(String input) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${widget.googleAPIKey}&language=${widget.language}";

    try {
      final response = await Dio().get(url);
      if (response.data['status'] == 'OK') {
        final List<Prediction> newPredictions = (response.data['predictions'] as List)
            .map((json) => Prediction.fromJson(json))
            .toList();
        setState(() {
          predictions = newPredictions;
        });
      } else {
        setState(() {
          predictions.clear();
        });
      }
    } catch (e) {
      print("Error fetching predictions: $e");
      setState(() {
        predictions.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.textEditingController,
          decoration: const InputDecoration(
            hintText: 'Buscar lugar...',
            border: OutlineInputBorder(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              final prediction = predictions[index];
              return ListTile(
                title: Text(prediction.description ?? ''),
                onTap: () {
                  if (widget.onItemClick != null) {
                    widget.onItemClick!(prediction);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
