package namedEntity;

public class Fecha extends NamedEntity{
	private	String precisa;
	private String forma_canonica;

	public Fecha(int frequency, String string, String nombre_canonico, String precisa, String forma_canonica) {
		super(string, nombre_canonico, frequency);
		this.precisa = precisa;
		this.forma_canonica = forma_canonica;
	}

	public String getPrecisa() {
		return this.precisa;
	}

	public void setPrecisa(String precisa) {
		this.precisa = precisa;
	}

	public String getFormaCanonica() {
		return this.forma_canonica;
	}
}
