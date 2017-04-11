package tests_contracts;

import farstar.ships.LightCombat;

public class Test06 extends LightCombat {

	public Test06(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getHull() {
		return -1;
	}

	public static void main(String[] args) {
		new Test06("v1", 10, 20, 100, 2);
	}

}
