import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/assintants/request_assistant.dart';
import 'package:user_app/global/map_key.dart';
import 'package:user_app/infoHandler/app_info.dart';
import 'package:user_app/models/directions.dart';
import 'package:user_app/models/predicted_places.dart';
import 'package:user_app/widgets/progress_dialog.dart';
import 'package:what3words/what3words.dart';

var api = What3WordsV3('XA2VZ7JX');
class PlacePredictionTileDesign extends StatelessWidget
{
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

// change
  getPlaceDirectionDetails(int? placeId, context) async
  {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Setting Up Drof-Off, Please wait...",
      ),
    );

    // String placeDirectionDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";
    String placeDirectionDetailsUrl = "https://api.what3words.com/v3/autosuggest?input=filled.count.sur&focus=21.1702%2C72.8311&clip-to-country=IN&key=XA2VZ7JX";


    var responseApi = await RequestAssistant.receiveRequest(placeDirectionDetailsUrl);

    Navigator.pop(context);

    if(responseApi == "Error Occurred, Failed. No Response.")
    {
      return;
    }

    // if(responseApi["status"] == "OK")
    else
    {
      Directions directions = Directions();
      // directions.LocationName = responseApi["result"]["name"];
      // directions.LocationId = placeId;
      // directions.locationLatitude = responseApi["result"]["geometry"]["location"]["lat"];
      // directions.locationLongitude = responseApi["result"]["geometry"]["location"]["lng"];
      //
      // Provider.of<AppInfo>(context, listen: false).updateDropOffLocationAddress(directions);

      directions.LocationName = responseApi["suggestions"]["nearestPlace"];
      directions.LocationId = placeId;
      // directions.locationLatitude = responseApi["result"]["geometry"]["location"]["lat"];
      // directions.locationLongitude = responseApi["result"]["geometry"]["location"]["lng"];

      Provider.of<AppInfo>(context, listen: false).updateDropOffLocationAddress(directions);

      Navigator.pop(context, "obtainedDropoff");
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: ()
      {
        getPlaceDirectionDetails(predictedPlaces!.place_id, context);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            const Icon(
              Icons.add_location,
              color: Colors.grey,
            ),
            const SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 2.0,),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
