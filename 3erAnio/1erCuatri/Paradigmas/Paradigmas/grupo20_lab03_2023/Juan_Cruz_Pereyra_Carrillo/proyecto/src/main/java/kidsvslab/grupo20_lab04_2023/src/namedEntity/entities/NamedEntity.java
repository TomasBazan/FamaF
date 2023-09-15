package namedEntity;

import java.io.Serializable;

/*Esta clase modela la nocion de entidad nombrada*/

public class NamedEntity implements Serializable {
	private String nombre_canonico;
	private String string;
	private int frequency;

	public NamedEntity(String string, String nombre_canonico, int frequency) {
		super();
		this.string = string;
		this.nombre_canonico = nombre_canonico;
		this.frequency = frequency;
	}

	public String getCanonicName() {
		return this.nombre_canonico;
	}

	public void setCanonicName(String nombre_canonico) {
		this.nombre_canonico = nombre_canonico;
	}

	public String getString() {
		return this.string;
	}

	public void setString(String string) {
		this.string = string;
	}

	public int getFrequency() {
		return this.frequency;
	}

	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}

	public boolean equals(String can_name) {
            return this.nombre_canonico == can_name;
	}

	public void incrementFrequency() {
		this.frequency++;
	}

	public void prettyPrint() {
		System.out.println("NamedEntity [nombre canonico=" + nombre_canonico + ", string=" + string + "]");
	}

	@Override
	public String toString() {
		return "ObjectNamedEntity [nombre canonico=" + nombre_canonico + ", string=" + string + "]";
	}


}
