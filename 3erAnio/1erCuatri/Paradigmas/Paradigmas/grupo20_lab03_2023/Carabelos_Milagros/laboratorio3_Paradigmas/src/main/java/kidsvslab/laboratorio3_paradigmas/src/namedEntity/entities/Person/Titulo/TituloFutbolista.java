package namedEntity.Titulo;
import namedEntity.interfaces.Football;
import namedEntity.Titulo.TituloBase;

public class TituloFutbolista extends TituloBase implements Football{
    private String team;
    private String position;
    private int pointsScored;
    
    public TituloFutbolista(int frequency, String string, String nombre_canonico, String person_id, String forma_canonica, String origen,  String footbal_team, String footbal_position, int pointsScored) {
        super(frequency, string, nombre_canonico, person_id, forma_canonica, origen);
        this.team = footbal_team;
        this.position = footbal_position;
        this.pointsScored = pointsScored;
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
    public void setPosition(String p){
        this.position = p;
    }
    
    @Override
    public String getPosition(){
        return this.position;
    }

    @Override
    public void incrementPointsScored(int p){
        this.pointsScored += p;
    }
    
    @Override
    public int getPointsScored(){
        return this.pointsScored;
    }
   
    @Override
    public void prettyPrint() {
        System.out.println("Titulo_Futbolista [pointsScored =" + getPointsScored() + ", footbal_team=" + getTeam() + ", footbal_position=" + getPosition() + ", forma canonica=" + getFormaCanonica()  + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }


}


