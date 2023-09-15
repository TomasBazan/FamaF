package namedEntity.Nombre;
import namedEntity.interfaces.Tech;
import java.util.List;

public class NombreTech extends NombreBase implements Tech {
    private String area;
    private List<String> products;

    public NombreTech(int frequency, String string, String nombre_canonico, String person_id, String nombre, String origen, List<String> formas_alternativas,  String area ,List<String> products) {
        super(frequency, string, nombre_canonico, person_id, nombre, origen, formas_alternativas);
    	this.area = area;
        this.products = products;
    }
    
    @Override
    public String getArea(){
        return this.area;
    }

    @Override
    public void setArea(String area){
        this.area = area;
    }

    @Override
    public List<String> getProducts(){
        return this.products;
    }

    @Override
    public void setProducts(List<String> products){
        this.products = products;
    }

    @Override
    public void prettyPrint() {
        System.out.println("Nombre_Tech [area=" + getArea() + "products" + getProducts()  + ", origen=" + getOrigen() + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }
}