package parser;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import feed.Feed;

/*Esta clase modela los atributos y metodos comunes a todos los distintos tipos de parser existentes en la aplicacion*/
public class GeneralParser {
    public static Date formatDate(String s) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.US);
        Date formatedDate = format.parse(s);
        return formatedDate;
    }
    
    public Feed handleParse(String s) throws IOException{
        return null;
    };
}
