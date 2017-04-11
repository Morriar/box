package tests_contracts;

import farstar.ships.LightCombat;
import farstar.ships.Speeder;
import farstar.ships.interfaces.Ship;
import farstar.weapons.exceptions.WeaponException;

public class Test20 extends LightCombat {

	public Test20(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
    public Boolean fire(Ship target) {
        return true;
    }


	public static void main(String[] args) throws WeaponException {
		Test20 t = new Test20("v1", 10, 20, 100, 2);
		
		Speeder target = new Speeder("v2", 10, 20, 100);
		t.fire(target);
	}

}
