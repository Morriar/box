package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.Phaser;
import farstar.weapons.Weapon;
import farstar.weapons.exceptions.WeaponException;

public class Test14 extends LightCombat {

	public Test14(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}
	
	@Override
	public void equip(Weapon weapon) throws WeaponException {
	}

	public static void main(String[] args) throws WeaponException {
		Test14 t = new Test14("v1", 10, 20, 100, 2);
		t.equip(new Phaser(10, 10, 10));
	}

}
