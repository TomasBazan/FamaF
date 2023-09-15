package namedEntity.Apellido;
import namedEntity.Person;
import java.util.ArrayList;
import java.util.List;

public class ApellidoBase extends Person{
	private	String forma_canonica;
	private String origen;

	public ApellidoBase(int frequency, String string, String nombre_canonico, String person_id, String forma_canonica, String origen) {
		super(frequency, string, nombre_canonico, person_id);
		this.forma_canonica = forma_canonica;
		this.origen = origen;
	}

	public void setFormaCanonica(String forma_canonica) {
		this.forma_canonica = forma_canonica;
	}
	public String getFormaCanonica() {
		return this.forma_canonica;
	}

	public void setOrigen(String origen) {
		this.origen = origen;
	}

	public String getOrigen() {
		return this.origen;
	}

        @Override
	public void prettyPrint() {
		System.out.println("Apellido [forma canonica=" + forma_canonica + ", origen=" + origen + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}
