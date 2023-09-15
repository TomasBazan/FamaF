package namedEntity.Titulo;
import namedEntity.Person;

public class TituloBase extends Person{
	private String profesional;
	private String forma_canonica;

	public TituloBase(int frequency, String string, String nombre_canonico, String person_id, String profesional, String forma_canonica) {
		super(frequency, string, nombre_canonico, person_id);
		this.profesional = profesional;
		this.forma_canonica = forma_canonica;
	}

	public String getProfesional() {
		return this.profesional;
	}

	public void setProfesional(String profesional) {
		this.profesional = profesional;
	}

	public String getFormaCanonica() {
		return this.forma_canonica;
	}

	public void setFormaCanonica(String forma_canonica) {
		this.forma_canonica = forma_canonica;
	}

	public void prettyPrint() {
		System.out.println("Titulo [profesional=" + profesional + ", forma canonica=" + forma_canonica + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}