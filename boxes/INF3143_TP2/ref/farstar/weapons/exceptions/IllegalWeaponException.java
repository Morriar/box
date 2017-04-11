/*
 * Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package farstar.weapons.exceptions;

/**
 * Illegal weapon exception.
 *
 * Exception thrown by a combat ship when client tries to equip a kind of weapon
 * that is not supported by the ship.
 */
@SuppressWarnings("serial")
public class IllegalWeaponException extends WeaponException {

}
