package tests_contracts;

import farstar.ships.LightCombat;

public class Test08 extends LightCombat {

	public Test08(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getHull() {
		return 100;
	}
	
	@Override
	public Boolean isDestroyed() {
		return true;
	}

	public static void main(String[] args) {
		new Test08("v1", 10, 20, 100, 2);
	}

}
