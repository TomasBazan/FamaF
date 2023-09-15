package namedEntity.Organizacion;
import java.util.List;
import namedEntity.interfaces.Basketball;


public class OrganizacionBasket extends OrganizacionBase implements Basketball {
    private String team;

    public  OrganizacionBasket(int frequency, String string, String nombre_canonico, String forma_canonica, int numeros_de_miembros, List<String> tipo_de_orgnanizacion, String team) {
        super(frequency, string, nombre_canonico, forma_canonica, numeros_de_miembros, tipo_de_orgnanizacion);
        this.team = team;
    }

    @Override
    public String getTeam() {
        return team;
    }

    @Override
    public void setTeam(String team) {
        this.team = team;
    } 

    @Override
    public void prettyPrint() {
       System.out.println("OrganizacionBasket [team=" + getTeam() + ", forma canonica=" + getFormaCanonica() + ", numeros de miembros=" + getNumerosDeMiembros() + ", tipo de organizacion=" + getTipoDeOrgnanizacion() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }

    @Override
    public String getPosition() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    @Override
    public void setPosition(String position) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    @Override
    public int getPointsScored() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    @Override
    public void setPointsScored(int pointsScored) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }
}