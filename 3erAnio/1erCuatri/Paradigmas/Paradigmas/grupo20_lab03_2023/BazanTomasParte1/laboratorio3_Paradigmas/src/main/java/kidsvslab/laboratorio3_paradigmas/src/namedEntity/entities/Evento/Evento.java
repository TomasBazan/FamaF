package namedEntity;

public class Evento extends NamedEntity{
	private	String forma_canonica;
	private String fecha;
	private String recurrente;

	public Evento(int frequency, String string, String nombre_canonico, String forma_canonica, String fecha, String recurrente) {
		super(string, nombre_canonico, frequency);
		this.forma_canonica = forma_canonica;
		this.fecha = fecha;
		this.recurrente = recurrente;
	}

	public String getFormaCanonica() {
		return this.forma_canonica;
	}

	public void setFormaCanonica(String forma_canonica) {
		this.forma_canonica = forma_canonica;
	}

	public String getFecha() {
		return this.fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	
	public String getRecurrente() {
		return this.recurrente;
	}

	public void setRecurrente(String recurrente) {
		this.recurrente = recurrente;
	}

	public void prettyPrint() {
		System.out.println("Evento [forma canonica=" + forma_canonica + ", fecha=" + fecha + ", recurrente=" + recurrente + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}
