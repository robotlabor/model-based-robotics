/*
 * generated by Xtext 2.23.0
 */
package hu.sze.aut.robot.description.scene.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import hu.sze.aut.robot.description.scene.RootElement
import hu.sze.aut.robot.description.scene.Model
import hu.sze.aut.robot.description.scene.Scene
import javax.xml.stream.XMLOutputFactory
import javax.xml.stream.XMLEventFactory
import javax.xml.stream.events.XMLEvent
import javax.xml.stream.events.StartDocument
import javax.xml.stream.XMLEventWriter
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import javax.xml.stream.events.StartElement
import javax.xml.stream.events.EndElement
import javax.xml.stream.events.Characters
import hu.sze.aut.robot.description.scene.InternalModel
import hu.sze.aut.robot.description.scene.ExternalModel
import hu.sze.aut.robot.description.scene.Placement
import hu.sze.aut.robot.description.scene.Box
import hu.sze.aut.robot.description.scene.WallElement
import hu.sze.aut.robot.description.scene.Color
import hu.sze.aut.robot.description.scene.Cylinder
import hu.sze.aut.robot.description.scene.Sphere

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class SceneDslGenerator extends AbstractGenerator {
	
	def static double deg2rad(double deg){
		return Math.PI*deg/180.0
	}
	
	def static generateSphere(XMLEventWriter eventWriter, String indent, InternalModel model, double radius){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		eventWriter.add(ind)
		val StartElement sphereStartElement = eventFactory.createStartElement("", "", "sphere")
		eventWriter.add(sphereStartElement)
		eventWriter.add(end)
		// Add radius
		eventWriter.add(ind)
		eventWriter.add(tab)
		val StartElement radiusStartElement = eventFactory.createStartElement("", "", "radius")		
		eventWriter.add(radiusStartElement)
		val Characters radiusVals = eventFactory.createCharacters('''«radius»''')
		eventWriter.add(radiusVals)
		val EndElement radiusEndElement = eventFactory.createEndElement("", "", "radius")
		eventWriter.add(radiusEndElement)
		// Closing element
		eventWriter.add(end)
		eventWriter.add(ind)
		val EndElement sphereEndElement = eventFactory.createEndElement("", "", "sphere")
		eventWriter.add(sphereEndElement)
		eventWriter.add(end)
	}
	
	def static generateCylinder(XMLEventWriter eventWriter, String indent, InternalModel model, 
		double radius, double height
	){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		eventWriter.add(ind)
		val StartElement boxStartElement = eventFactory.createStartElement("", "", "cylinder")
		eventWriter.add(boxStartElement)
		eventWriter.add(end)
		// Add radius
		eventWriter.add(ind)
		eventWriter.add(tab)
		val StartElement radiusStartElement = eventFactory.createStartElement("", "", "radius")		
		eventWriter.add(radiusStartElement)
		val Characters radiusVals = eventFactory.createCharacters('''«radius»''')
		eventWriter.add(radiusVals)
		val EndElement radiusEndElement = eventFactory.createEndElement("", "", "radius")
		eventWriter.add(radiusEndElement)
		// Add height
		eventWriter.add(ind)
		eventWriter.add(tab)
		val StartElement heightStartElement = eventFactory.createStartElement("", "", "height")		
		eventWriter.add(heightStartElement)
		val Characters heightVals = eventFactory.createCharacters('''«height»''')
		eventWriter.add(heightVals)
		val EndElement heightEndElement = eventFactory.createEndElement("", "", "height")
		eventWriter.add(heightEndElement)
		// Closing element
		eventWriter.add(end)
		eventWriter.add(ind)
		val EndElement boxEndElement = eventFactory.createEndElement("", "", "box")
		eventWriter.add(boxEndElement)
		eventWriter.add(end)
	}
	
	def generateBox(XMLEventWriter eventWriter, String indent, InternalModel model, 
		double depth, double width, double height
	){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		eventWriter.add(ind)
		val StartElement boxStartElement = eventFactory.createStartElement("", "", "box")
		eventWriter.add(boxStartElement)
		eventWriter.add(end)
		// Add size
		eventWriter.add(ind)
		eventWriter.add(tab)
		val StartElement boxSizeStartElement = eventFactory.createStartElement("", "", "size")		
		eventWriter.add(boxSizeStartElement)
		val Characters sizeVals = eventFactory.createCharacters('''«depth» «width» «height»''')
		eventWriter.add(sizeVals)
		val EndElement boxSizeEndElement = eventFactory.createEndElement("", "", "size")
		eventWriter.add(boxSizeEndElement)
		// Closing element
		eventWriter.add(end)
		eventWriter.add(ind)
		val EndElement boxEndElement = eventFactory.createEndElement("", "", "box")
		eventWriter.add(boxEndElement)
		eventWriter.add(end)
	}
	
	def generateGeometryElement(XMLEventWriter eventWriter, String indent, InternalModel model){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		// Collision element generate
		// Geometry setup
		val StartElement visualGeometryStartElement = eventFactory.createStartElement("", "", "geometry")
		eventWriter.add(ind)
		eventWriter.add(visualGeometryStartElement)
		eventWriter.add(end)
		// Geometry definition
		if (model instanceof Box){			
			generateBox(eventWriter, indent+"\t", model, model.depth, model.width, model.height)			
		}
		else if (model instanceof Cylinder){
			generateCylinder(eventWriter, indent+"\t", model, model.radius, model.height)
		}
		else if (model instanceof Sphere){
			generateSphere(eventWriter, indent+"\t", model, model.radius)
		}
		else if (model instanceof WallElement){
			generateBox(eventWriter, indent+"\t", model, 0.05, model.width, model.height)
		}
		// Closing geometry elements
		val EndElement   visualGeometryEndElement   = eventFactory.createEndElement("", "", "geometry")
		eventWriter.add(ind)
		eventWriter.add(visualGeometryEndElement)
		eventWriter.add(end)
	}
	
	def generateLinkElement(XMLEventWriter eventWriter, String indent, InternalModel model){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		eventWriter.add(ind)
		// Visual element generate
		val StartElement visualStartElement = eventFactory.createStartElement("", "", "visual")
		eventWriter.add(visualStartElement)
		eventWriter.add(eventFactory.createAttribute("name", '''visual_«model.name»'''))
		eventWriter.add(end)
		// Generate geometry element
		generateGeometryElement(eventWriter, indent+"\t", model)
		// Add material element
		val StartElement materialStartElement = eventFactory.createStartElement("", "", "material")
		eventWriter.add(ind)
		eventWriter.add(tab)
		eventWriter.add(materialStartElement)
		eventWriter.add(end)
		// Diffuse color
		if (model.material instanceof Color){
			val Color color = model.material as Color
			eventWriter.add(ind)
			eventWriter.add(tab)
			eventWriter.add(tab)
			val StartElement diffuseStartElement = eventFactory.createStartElement("", "", "ambient")		
			eventWriter.add(diffuseStartElement)
			val Characters diffuseColor = eventFactory.createCharacters('''«color.red» «color.green» «color.blue» «1.0»''')
			eventWriter.add(diffuseColor)
			val EndElement diffuseEndElement = eventFactory.createEndElement("", "", "ambient")
			eventWriter.add(diffuseEndElement)
			eventWriter.add(end)
		}
		// Closing material element		
		val EndElement   materialEndElement   = eventFactory.createEndElement("", "", "material")
		eventWriter.add(ind)
		eventWriter.add(tab)
		eventWriter.add(materialEndElement)
		eventWriter.add(end)
		// Closing visual element
		val EndElement visualEndElement = eventFactory.createEndElement("", "", "visual")
		eventWriter.add(ind)
		eventWriter.add(visualEndElement)
		eventWriter.add(end)
		// Add collision element
		val StartElement collisionStartElement = eventFactory.createStartElement("", "", "collision")
		eventWriter.add(ind)
		eventWriter.add(collisionStartElement)
		eventWriter.add(eventFactory.createAttribute("name", '''collision_«model.name»'''))
		eventWriter.add(end)
		// Add collision geometry
		generateGeometryElement(eventWriter, indent+"\t", model)
		// Close collision element
		val EndElement collisionEndElement = eventFactory.createEndElement("", "", "collision")
		eventWriter.add(ind)
		eventWriter.add(collisionEndElement)
		eventWriter.add(end)
	}
	
	def generateInternalModel(XMLEventWriter eventWriter, String indent, InternalModel model){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		// START INTERNAL MODEL
		eventWriter.add(ind)
		val StartElement startElement = eventFactory.createStartElement("", "", "link")
		eventWriter.add(startElement)
		eventWriter.add(eventFactory.createAttribute("name", '''link_«model.name»'''))
		eventWriter.add(end)
		generateLinkElement(eventWriter, indent+"\t", model)
		// END INTERNAL MODEL
		eventWriter.add(ind)
		val EndElement endElement = eventFactory.createEndElement("", "", "link")
		eventWriter.add(endElement)
	}
	
	def generatePoseElement(XMLEventWriter eventWriter, Placement placement){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent tab = eventFactory.createDTD("\t")
		val XMLEvent end = eventFactory.createDTD("\n")		
		// Pose element
		val StartElement poseStartElement = eventFactory.createStartElement("", "", "pose")
		eventWriter.add(poseStartElement)
		var Characters poseVals = null
		if (placement.position!==null && placement.rotation!==null)	{
			poseVals = eventFactory.createCharacters('''«placement?.position.x» «placement?.position.y» «placement?.position.z» «deg2rad(placement?.rotation.roll)» «deg2rad(placement?.rotation.pitch)» «deg2rad(placement?.rotation.yaw)»''')
		}
		else if (placement.position!==null){
			poseVals = eventFactory.createCharacters('''«placement?.position.x» «placement?.position.y» «placement?.position.z» 0.0 0.0 0.0''')
		}
		else if (placement.rotation!==null){
			poseVals = eventFactory.createCharacters('''0.0 0.0 0.0 «deg2rad(placement?.rotation.roll)» «deg2rad(placement?.rotation.pitch)» «deg2rad(placement?.rotation.yaw)»''')
		}
		eventWriter.add(poseVals)
		val EndElement   poseEndElement = eventFactory.createEndElement("", "", "pose")
		eventWriter.add(poseEndElement)
	}
	
	def generateModel(XMLEventWriter eventWriter, String indent, Model model){
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent ind = eventFactory.createDTD(indent)
		val XMLEvent tab = eventFactory.createDTD("\t")
		eventWriter.add(ind)
		// Act on internal or external models
		if (model instanceof InternalModel)	{
			// Create start	
			val StartElement startElement = eventFactory.createStartElement("", "", "model")
			eventWriter.add(startElement)
			eventWriter.add(eventFactory.createAttribute("name", model.name))
			eventWriter.add(end)
			// Indicate if static element
			if (model instanceof WallElement){
				eventWriter.add(ind)
				eventWriter.add(tab)
				val StartElement staticStartElement = eventFactory.createStartElement("", "", "static")
				eventWriter.add(staticStartElement)
				val Characters staticCh = eventFactory.createCharacters('''«1»''')
				eventWriter.add(staticCh) 
				val EndElement staticEndElement = eventFactory.createEndElement("", "", "static")
				eventWriter.add(staticEndElement)
				eventWriter.add(end)
			}
			// Indent in		
			eventWriter.add(ind)
			eventWriter.add(tab)
			generatePoseElement(eventWriter, model.placement)
			eventWriter.add(end)
			// Generate geometry, visual, collision etc.
			//eventWriter.add(tab)
			generateInternalModel(eventWriter, indent + "\t", model)
			eventWriter.add(end)
			// Close element
			eventWriter.add(ind)  
			val EndElement endElement = eventFactory.createEndElement("", "", "model")
			eventWriter.add(endElement)
		}
		else if (model instanceof ExternalModel){
			// Nothing really to do, just add an include element
			// Starting element
			val StartElement include_startElement = eventFactory.createStartElement("", "", "include")			
			eventWriter.add(include_startElement)
			eventWriter.add(end)
			// URI element
			eventWriter.add(ind)
			eventWriter.add(tab)
			val StartElement uriStartElement = eventFactory.createStartElement("", "", "uri")
			eventWriter.add(uriStartElement)
			val Characters uriVals = eventFactory.createCharacters('''«model.path»''')
			eventWriter.add(uriVals)
			val EndElement   uriEndElement   = eventFactory.createEndElement("", "", "uri")
			eventWriter.add(uriEndElement)
			eventWriter.add(end)
			// Placement of object
			if (model.placement!==null){
				generatePoseElement(eventWriter, model.placement)			
			}
			// Closing element
			eventWriter.add(ind)
			val EndElement   include_endElement   = eventFactory.createEndElement("", "", "include")
			eventWriter.add(include_endElement)
		}
		eventWriter.add(end)
	}

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val RootElement rootElement = resource.allContents.filter[it instanceof RootElement].head as RootElement
		/// XML setup
		val XMLOutputFactory outputFactory = XMLOutputFactory.newInstance()
		val bos = new ByteArrayOutputStream()
		val XMLEventWriter eventWriter = outputFactory.createXMLEventWriter(bos)
		val XMLEventFactory eventFactory = XMLEventFactory.newInstance()
		val XMLEvent end = eventFactory.createDTD("\n")
		val XMLEvent tab = eventFactory.createDTD("\t")
		// SDF element
		val StartDocument startDocument = eventFactory.createStartDocument()
		eventWriter.add(startDocument)
		eventWriter.add(end)
		val StartElement startElement = eventFactory.createStartElement("","","sdf")
		eventWriter.add(startElement)
		eventWriter.add(eventFactory.createAttribute("version", "1.5"))
		eventWriter.add(end)
		// Act on root element
		if (rootElement instanceof Model){
			// TODO: implement it		
		}		
		else if (rootElement instanceof Scene){
			// Create world
			eventWriter.add(tab)
			val StartElement worldStartElement = eventFactory.createStartElement("","","world")
			eventWriter.add(worldStartElement)
			eventWriter.add(eventFactory.createAttribute("name", '''«rootElement.name»'''))
			eventWriter.add(end)
			// Act on world objects
			val sceneElement = rootElement as Scene
			for (model: sceneElement.model)	{
				generateModel(eventWriter, "\t\t", model)
			}
			// Close world element
			eventWriter.add(tab)
			val EndElement worldEndElement = eventFactory.createEndElement("","","world")
			eventWriter.add(worldEndElement)
			eventWriter.add(end)
		}
		// Close SDF
		val EndElement endElement = eventFactory.createEndElement("","","sdf")
		eventWriter.add(endElement)
		eventWriter.add(end)
		
		// Generate file		
		val bis = new ByteArrayInputStream(bos.toByteArray)
		fsa.generateFile('''«rootElement.name».sdf''',bis)		
		
	}
}
