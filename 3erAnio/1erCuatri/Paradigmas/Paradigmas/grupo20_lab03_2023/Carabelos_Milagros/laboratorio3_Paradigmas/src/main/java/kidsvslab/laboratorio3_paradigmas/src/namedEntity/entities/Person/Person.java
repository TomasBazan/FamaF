package namedEntity;
import namedEntity.NamedEntity;
import java.util.ArrayList;
import java.util.List;

public class Person extends NamedEntity{
	private	String person_id;

	public String getPersonId() {
		return this.person_id;
	}

	public Person(int frequency, String string, String nombre_canonico, String person_id) {
		super(string, nombre_canonico, frequency);
		this.person_id = person_id;
	}

	public void setPersonId(String person_id) {
		this.person_id = person_id;
	}
	public void prettyPrint() {
		System.out.println("Person [person_id=" + person_id + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}

}
