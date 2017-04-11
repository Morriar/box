package tests_contracts;

import farstar.ships.LightCombat;

public class Test01 extends LightCombat {

	public Test01(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public String getId() {
		return null;
	}

	public static void main(String[] args) {
		new Test01("v1", 10, 20, 100, 2);
	}

}
