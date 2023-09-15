package namedEntity.Organizacion;
import java.util.List;
import namedEntity.interfaces.Politic;

public class OrganizacionPolitic extends OrganizacionBase implements Politic{
    private String party;
    private String position;
    private String country;

    public OrganizacionPolitic(int frequency, String string, String nombre_canonico, String forma_canonica, int numeros_de_miembros, List<String> tipo_de_orgnanizacion, String party, String position, String country) {
        super(frequency, string, nombre_canonico, forma_canonica, numeros_de_miembros, tipo_de_orgnanizacion);
        this.party = party;
        this.position = position;
        this.country = country;
    }

    public String getParty(){
        return this.party;
    }

    @Override
    public void setParty(String party){
        this.party = party;
    }

    @Override
    public String getPosition(){
        return this.position;
    }

    @Override
    public void setPosition(String position){
        this.position = position;
    }

    @Override
    public String getCountry(){
        return this.country;
    }

    @Override
    public void setCountry(String country){
        this.country = country;
    }

    @Override
    public void prettyPrint() {
        System.out.println("OrganizacionPolitica [party=" + getParty() + ", position=" + getPosition() + ", country=" + getCountry()  + ", forma canonica=" + getFormaCanonica() + ", numeros de miembros=" + getNumerosDeMiembros() + ", tipo de organizacion=" + getTipoDeOrgnanizacion() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }
}