/*
 * generated by Xtext 2.23.0
 */
package hu.sze.aut.robot.description.scene.ide;

import com.google.inject.Guice;
import com.google.inject.Injector;
import hu.sze.aut.robot.description.scene.SceneDslRuntimeModule;
import hu.sze.aut.robot.description.scene.SceneDslStandaloneSetup;
import org.eclipse.xtext.util.Modules2;

/**
 * Initialization support for running Xtext languages as language servers.
 */
public class SceneDslIdeSetup extends SceneDslStandaloneSetup {

	@Override
	public Injector createInjector() {
		return Guice.createInjector(Modules2.mixin(new SceneDslRuntimeModule(), new SceneDslIdeModule()));
	}
	
}