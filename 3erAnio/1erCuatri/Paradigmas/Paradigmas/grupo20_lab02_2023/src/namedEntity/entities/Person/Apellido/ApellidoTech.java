package namedEntity.Apellido;
import namedEntity.interfaces.Tech;
import java.util.List;

public class ApellidoTech extends ApellidoBase implements Tech {
    private String area;
    private List<String> products;

    public ApellidoTech(int frequency, String string, String nombre_canonico, String person_id, String forma_canonica, String origen, String area ,List<String> products) {
        super(frequency, string, nombre_canonico, person_id, forma_canonica, origen);
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
        System.out.println("Apellido_Tech [area=" + getArea() + "products" + getProducts() + ", forma canonica=" + getFormaCanonica() + ", origen=" + getOrigen() + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }
}