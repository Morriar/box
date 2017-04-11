package tests_contracts;

import farstar.ships.LightCombat;

public class Test03 extends LightCombat {

	public Test03(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getVolume() {
		return 0;
	}

	public static void main(String[] args) {
		new Test03("v1", 10, 20, 100, 2);
	}

}
