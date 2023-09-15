package namedEntity.Nombre;
import namedEntity.Person;
import java.util.ArrayList;
import java.util.List;

public class NombreBase extends Person {
	private	String nombre;
	private String origen;
	private List<String> formas_alternativas = new ArrayList<String>();

	public String getNombre() {
		return this.nombre;
	}

	public NombreBase(int frequency, String string, String nombre_canonico, String person_id, String nombre, String origen, List<String> formas_alternativas) {
		super(frequency, string, nombre_canonico, person_id);
		this.nombre = nombre;
		this.origen = origen;
		this.formas_alternativas = formas_alternativas;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setOrigen(String origen) {
		this.origen = origen;
	}

	public String getOrigen() {
		return this.origen;
	}

	public void addFormaAlternativa(String forma_alternativa) {
		this.formas_alternativas.add(forma_alternativa);
	}

	public List<String> getFormasAlternativas() {
		return this.formas_alternativas;
	}

	public void prettyPrint() {
		System.out.println("Nombre [nombre=" + nombre + ", origen=" + origen + ", formas alternativas=" + formas_alternativas + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}


