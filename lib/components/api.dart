import 'package:http/http.dart' as http;
class CallApi{
    final String _token = "U2FsdGVkX19v3p/y/4GqKQEjXBD/+xlcN6VEK6XadPM=";
    final String _url = "https://demos.conexus-group.com/ApiEcoinsJuegoUAT/api/v1/";
    static String Finalcountry = "";
    postDataStart(age, country, gender, apiURL) async {
      Finalcountry = country;
      var fullURL = _url+apiURL+"/?token="+_token+"&pais="+country+"&edad="+age+"&genero="+gender;
      print(fullURL);
      return await http.post(
        Uri.parse(fullURL),
          headers: {'Content-Type':'text/plain'}
      );
    }
    postDataEnd(email, ecoins, apiURL) async {
      var fullURL = _url + apiURL + "/?token=" + _token + "&pais=" +Finalcountry +"&email=" + email + "&ecoins=" + ecoins.toString();
      print(fullURL);
      return await http.post(
          Uri.parse(fullURL),
          headers: {'Content-Type':'text/plain'}
      );
    }
}