package tests_contracts;

import farstar.ships.LightCombat;
import farstar.ships.Speeder;
import farstar.ships.interfaces.Ship;
import farstar.weapons.Phaser;
import farstar.weapons.exceptions.WeaponException;

public class Test21 extends LightCombat {

	public Test21(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
    public Boolean fire(Ship target) {
        return false;
    }


	public static void main(String[] args) throws WeaponException {
		Test21 t = new Test21("v1", 10, 20, 100, 2);
		t.equip(new Phaser(10, 10, 10));
		
		Speeder target = new Speeder("v2", 10, 20, 100);
		t.fire(target);
	}

}
