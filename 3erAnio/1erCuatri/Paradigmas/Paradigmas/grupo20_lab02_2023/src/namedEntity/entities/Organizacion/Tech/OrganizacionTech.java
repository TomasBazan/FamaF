package namedEntity.Organizacion;
import java.util.List;
import namedEntity.interfaces.Tech;


public class OrganizacionTech extends OrganizacionBase implements Tech {
    private String area;
    private List<String> products;

    public  OrganizacionTech(int frequency, String string, String nombre_canonico, String forma_canonica, int numeros_de_miembros, List<String> tipo_de_orgnanizacion, String area, List<String> products) {
        super(frequency, string, nombre_canonico, forma_canonica, numeros_de_miembros, tipo_de_orgnanizacion);
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
        System.out.println("Organizacion_Tech [area=" + getArea() + "products" + getProducts() + ", forma canonica=" + getFormaCanonica() + ", numeros_de_miembros=" + getNumerosDeMiembros() + ", tipo_de_orgnanizacion=" + getTipoDeOrgnanizacion() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }

}