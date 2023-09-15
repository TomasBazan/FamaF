package namedEntity.Organizacion;
import java.util.List;
import namedEntity.interfaces.F1Racer;


public class OrganizacionF1 extends OrganizacionBase implements F1Racer {
    private String team;

    public  OrganizacionF1(int frequency, String string, String nombre_canonico, String forma_canonica, int numeros_de_miembros, List<String> tipo_de_orgnanizacion, String team) {
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
       System.out.println("OrganizacionF1 [team=" + getTeam() + ", forma canonica=" + getFormaCanonica() + ", numeros de miembros=" + getNumerosDeMiembros() + ", tipo de organizacion=" + getTipoDeOrgnanizacion() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }

    @Override
    public String getCar() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setCar(String car) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}