package namedEntity.Titulo;
import namedEntity.interfaces.Tenis;

public class TituloTenista extends TituloBase implements Tenis {
    private int pointsScored;

    public TituloTenista(int frequency, String string, String nombre_canonico, String person_id, String forma_canonica, String origen,  int tenis_points) {
        super(frequency, string, nombre_canonico, person_id, forma_canonica, origen);
    	this.pointsScored = tenis_points;
    }
    
    @Override
    public int getPointsScored(){
        return this.pointsScored;
    }
    @Override
    public void setPointsScored(int pointsScored){
        this.pointsScored = pointsScored;
    }
    @Override
    public void prettyPrint() {
        System.out.println("Titulo_Tenista [points=" + getPointsScored() + ", forma canonica=" + getFormaCanonica() + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }
}