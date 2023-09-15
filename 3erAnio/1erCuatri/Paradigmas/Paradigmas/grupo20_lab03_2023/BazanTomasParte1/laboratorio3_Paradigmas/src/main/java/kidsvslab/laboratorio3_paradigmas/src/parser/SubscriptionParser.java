package parser;

import org.json.JSONArray;
import org.json.JSONObject;
import java.io.FileReader;
import org.json.JSONObject;
import org.json.JSONTokener;
import java.io.IOException;
import subscription.SingleSubscription;
import subscription.Subscription;

/*
 * Esta clase implementa el parser del  archivo de suscripcion (json)
 * Leer https://www.w3docs.com/snippets/java/how-to-parse-json-in-java.html
 * */

public class SubscriptionParser extends GeneralParser {

    public JSONArray parseJson(String filePath) throws IOException {
        JSONArray root;
        try (
            FileReader reader = new FileReader(filePath)) {
            JSONTokener tokener = new JSONTokener(reader);
            root = new JSONArray(tokener);
        }
        return root;
    }


    public Subscription makeResponse(JSONArray jsonObj){
        Subscription ret = new Subscription(null);
        for (int i = 0; i < jsonObj.length(); i++) {
            SingleSubscription subs = new SingleSubscription(null, null, null);
            JSONObject subscription = jsonObj.getJSONObject(i);
            String urlType = subscription.getString("urlType");

            JSONArray urlParams = subscription.getJSONArray("urlParams");
            String url = subscription.getString("url");
            for (int j = 0; j < urlParams.length(); j++) {
                subs.setUlrParams(urlParams.getString(j));
            }
            subs.setUrl(url);
            subs.setUrlType(urlType);
            ret.addSingleSubscription(subs);
        }
        return ret;
    }


    public Subscription parseFile(String filePath) throws IOException {
       // Obtenemos el json
       JSONArray jsonObj = parseJson(filePath);

       // Obtenemos la response
       return makeResponse(jsonObj);
    }

    public Subscription handleParseSuscription(String s) throws IOException{
        Subscription response = parseFile(s);
        return response;
    }
}
