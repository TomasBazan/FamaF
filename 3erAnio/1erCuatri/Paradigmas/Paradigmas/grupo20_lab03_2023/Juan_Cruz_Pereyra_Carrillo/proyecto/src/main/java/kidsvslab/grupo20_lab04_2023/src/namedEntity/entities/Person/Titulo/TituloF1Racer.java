package namedEntity.Titulo;
import namedEntity.interfaces.F1Racer;

public class TituloF1Racer extends TituloBase implements F1Racer {
    private String team;
    private String car;
   
    public TituloF1Racer(int frequency, String string, String nombre_canonico, String person_id, String forma_canonica, String origen,  String team, String car) {
        super(frequency, string, nombre_canonico, person_id, forma_canonica, origen);
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
        System.out.println("Titulo_F1Racer [team=" + getTeam() + ", forma canonica=" + getFormaCanonica()  + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }

    @Override
    public String getCar() {
        return this.car;
    }

    public void setCar(String name) {
        this.car = name;
    }
}