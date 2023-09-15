package namedEntity.Apellido;
import namedEntity.interfaces.Politic;
import namedEntity.Apellido.ApellidoBase;

public class ApellidoPolitico extends ApellidoBase implements Politic{
    private String politic_party;
    private String politic_position;
    private String politic_country;
    
    public ApellidoPolitico(int frequency, String string, String nombre_canonico, String person_id, String forma_canonica, String origen,  String politic_party, String politic_position, String politic_country) {
        super(frequency, string, nombre_canonico, person_id, forma_canonica, origen);
		this.politic_party = politic_party;
		this.politic_position = politic_position;
		this.politic_country = politic_country;
	}

    @Override
    public String getParty(){
        return this.politic_party;
    }

    @Override
    public void setParty(String party){
        this.politic_party = party;
    }

    @Override
    public String getPosition(){
        return this.politic_position;
    }

    @Override
    public void setPosition(String position){
        this.politic_position = position;
    }

    @Override
    public String getCountry(){
        return this.politic_country;
    }

    @Override
    public void setCountry(String country){
        this.politic_country = country;
    }

    @Override
	public void prettyPrint() {
		System.out.println("ApellidoPoliticoN [politic_party=" + politic_party + ", politic_position=" + politic_position + ", politic_country=" + politic_country + ", forma canonica=" + getFormaCanonica() + ", origen=" + getOrigen() + ", person_id=" + getPersonId() + ", nombre canonico=" + getCanonicName() + ", string=" + getString() + "]");
	}
}

