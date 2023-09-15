package namedEntity.Lugar;


public class Ciudad extends LugarBase {
	private String ciudad;
	private String poblacion;	
	private String capital;
	private String pais;

	public Ciudad(int frequency, String string, String nombre_canonico, String lugar_id, String poblacion, String capital, String pais, String ciudad) {
		super(frequency, string, nombre_canonico, lugar_id);
		this.poblacion = poblacion;
		this.capital = capital;
		this.pais = pais;
		this.ciudad = ciudad;
	}

	public String getPoblacion() {
		return this.poblacion;
	}

	public void setPoblacion(String poblacion) {
		this.poblacion = poblacion;
	}

	public String getCapital() {
		return this.capital;
	}

	public void setCapital(String capital) {
		this.capital = capital;
	}

	public String getPais() {
		return this.pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
	}

	public String getCiudad() {
		return this.ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}

	public void prettyPrint() {
		System.out.println("Ciudad [poblacion=" + poblacion + ", capital=" + capital + ", pais=" + pais + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}