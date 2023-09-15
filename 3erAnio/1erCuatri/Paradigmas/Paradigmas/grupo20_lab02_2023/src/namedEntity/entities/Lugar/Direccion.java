package namedEntity.Lugar;
import namedEntity.Lugar.LugarBase;

public class Direccion extends LugarBase {
	private String ciudad;
	private String calle;

	public Direccion(int frequency, String string, String nombre_canonico, String lugar_id, String ciudad, String calle) {
		super(frequency, string, nombre_canonico, lugar_id);
		this.ciudad = ciudad;
		this.calle = calle;
	}

	public String getCiudad() {
		return this.ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}

	public String getCalle() {
		return this.calle;
	}

	public void setCalle(String calle) {
		this.calle = calle;
	}
}