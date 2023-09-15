package namedEntity;

public class Producto extends NamedEntity{
	private	String comercial;
	private String productor;

	public Producto(int frequency, String string, String nombre_canonico, String comercial, String productor) {
		super(string, nombre_canonico, frequency);
		this.comercial = comercial;
		this.productor = productor;
	}

	public String getComercial() {
		return this.comercial;
	}
	
	public void setComercial(String comercial) {
		this.comercial = comercial;
	}

	public String getProductor() {
		return this.productor;
	}

	public void setProductor(String productor) {
		this.productor = productor;
	}

	public void prettyPrint() {
		System.out.println("Producto [comercial=" + comercial + ", productor=" + productor + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}

