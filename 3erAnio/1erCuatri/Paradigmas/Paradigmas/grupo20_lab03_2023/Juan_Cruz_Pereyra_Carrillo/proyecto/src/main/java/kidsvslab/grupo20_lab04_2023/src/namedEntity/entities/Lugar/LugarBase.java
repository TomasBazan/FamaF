package namedEntity.Lugar;
import namedEntity.NamedEntity;

public class LugarBase extends NamedEntity{
	private	String lugar_id;

	public LugarBase(int frequency, String string, String nombre_canonico, String lugar_id) {
		super(string, nombre_canonico, frequency);
		this.lugar_id = lugar_id;
	}

	public String getLugarId() {
		return this.lugar_id;
	}

	public void setLugarId(String lugar_id) {
		this.lugar_id = lugar_id;
	}

        @Override
	public void prettyPrint() {
		System.out.println("Lugar [lugar_id=" + lugar_id + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}

