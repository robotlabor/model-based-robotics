/*
 * generated by Xtext 2.23.0
 */
package hu.sze.aut.robot.description.scene;


/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
public class SceneDslStandaloneSetup extends SceneDslStandaloneSetupGenerated {

	public static void doSetup() {
		new SceneDslStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}
