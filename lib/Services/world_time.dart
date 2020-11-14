import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({ this.location, this.flag, this.url });
  bool m = true;
  Future<void> getTime() async {
      try {
        Response response = await get('http://worldtimeapi.org/api/timezone/$url');
        Map data = jsonDecode(response.body);

        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(1,3);
        String sign = data['utc_offset'].substring(0,1);
        print(sign);

        DateTime now = DateTime.parse(datetime);
        if(sign == '-'){
          now = now.subtract(Duration(hours: int.parse(offset)));
        }
        else{
          now = now.add(Duration(hours: int.parse(offset)));
        }

        isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

        time = DateFormat.jm().format(now);
      }
      catch(e) {
        print('sorry could not load data!!!!');
        time = 'Could not get time';
      }



  }

}

WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');