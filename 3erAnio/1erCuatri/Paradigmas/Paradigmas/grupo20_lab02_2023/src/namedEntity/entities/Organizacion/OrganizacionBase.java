package namedEntity.Organizacion;
import namedEntity.NamedEntity;
import java.util.List;

public class OrganizacionBase extends NamedEntity{
	private	String forma_canonica;
	private int numeros_de_miembros;
	private List<String> tipo_de_orgnanizacion;

	public OrganizacionBase (int frequency, String string, String nombre_canonico, String forma_canonica, int numeros_de_miembros, List<String> tipo_de_orgnanizacion) {
            super(string, nombre_canonico, frequency);
            this.forma_canonica = forma_canonica;
            this.numeros_de_miembros = numeros_de_miembros;
            this.tipo_de_orgnanizacion = tipo_de_orgnanizacion;
	}

	public String getFormaCanonica() {
		return this.forma_canonica;
	}

	public void setFormaCanonica(String forma_canonica) {
		this.forma_canonica = forma_canonica;
	}

	public int getNumerosDeMiembros() {
		return this.numeros_de_miembros;
	}

	public void setNumerosDeMiembros(int numeros_de_miembros) {
		this.numeros_de_miembros = numeros_de_miembros;
	}

	public List<String> getTipoDeOrgnanizacion() {
		return this.tipo_de_orgnanizacion;
	}

	public void setTipoDeOrgnanizacion(List<String> tipo_de_orgnanizacion) {
		this.tipo_de_orgnanizacion = tipo_de_orgnanizacion;
	}

	public void prettyPrint() {
		System.out.println("Organizacion [forma canonica=" + forma_canonica + ", numeros de miembros=" + numeros_de_miembros + ", tipo de organizacion=" + tipo_de_orgnanizacion + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}
