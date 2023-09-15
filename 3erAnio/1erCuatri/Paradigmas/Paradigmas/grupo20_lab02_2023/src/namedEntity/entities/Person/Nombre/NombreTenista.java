package namedEntity.Nombre;
import java.util.List;
import namedEntity.interfaces.Tenis;

public class NombreTenista extends NombreBase implements Tenis {
    private int pointsScored;

    public NombreTenista(int frequency, String string, String nombre_canonico, String person_id, String nombre, String origen, List<String> formas_alternativas, int tenis_points) {
        super(frequency, string, nombre_canonico, person_id, nombre, origen, formas_alternativas);
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
        System.out.println("Nombre_Tenista [points=" + getPointsScored()  + ", origen=" + getOrigen() + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
    }
}