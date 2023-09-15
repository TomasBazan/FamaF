package namedEntity.Lugar;

public class Pais extends LugarBase {
	private String pais;
	private String poblacion;
	private String lengua_oficial;

	public Pais(int frequency, String string, String nombre_canonico, String lugar_id, String poblacion, String lengua_oficial, String pais) {
		super(frequency, string, nombre_canonico, lugar_id);
		this.poblacion = poblacion;
		this.lengua_oficial = lengua_oficial;
		this.pais = pais;
	}

	public String getPais() {
		return this.pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
	}

	public String getPoblacion() {
		return this.poblacion;
	}

	public void setPoblacion(String poblacion) {
		this.poblacion = poblacion;
	}

	public String getLenguaOficial() {
		return this.lengua_oficial;
	}

	public void setLenguaOficial(String lengua_oficial) {
		this.lengua_oficial = lengua_oficial;
	}

	public void prettyPrint() {
		System.out.println("Pais [poblacion=" + poblacion + ", lengua oficial=" + lengua_oficial + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}
