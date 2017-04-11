package tests_contracts;

import farstar.ships.LightCombat;

public class Test02 extends LightCombat {

	public Test02(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public String getId() {
		return "";
	}

	public static void main(String[] args) {
		new Test02("v1", 10, 20, 100, 2);
	}

}
