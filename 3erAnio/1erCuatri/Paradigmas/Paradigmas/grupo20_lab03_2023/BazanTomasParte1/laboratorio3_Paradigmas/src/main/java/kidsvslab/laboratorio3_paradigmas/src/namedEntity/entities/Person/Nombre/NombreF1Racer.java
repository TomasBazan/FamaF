package namedEntity.Nombre;
import java.util.List;
import namedEntity.interfaces.F1Racer;

public class NombreF1Racer extends NombreBase implements F1Racer {
    private String team;
    private String car;
   
    public NombreF1Racer(int frequency, String string, String nombre_canonico, String person_id, String nombre, String origen, List<String> formas_alternativas, String team, String car) {
        super(frequency, string, nombre_canonico, person_id, nombre, origen, formas_alternativas);
        this.team = team;
        this.car = car;
    }
    
    @Override
    public String getTeam(){
            return this.team;
    }
        
    @Override
    public void setTeam(String t){
        this.team = t;
    }
        
    @Override
    public void prettyPrint() {
        System.out.println("Nombre_F1Racer [team=" + getTeam()  + ", origen=" + getOrigen() + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }

    @Override
    public String getCar() {
        return this.car;
    }

    public void setCar(String name) {
        this.car = name;
    }
}