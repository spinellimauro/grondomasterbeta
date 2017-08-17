package controller

import datos.SoFifa
import java.util.List
import master.DT
import master.Jugador
import master.LigaMaster
import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController

@RestController
@EnableAutoConfiguration
class MasterController {
	
//	@Autowired
//   	Data data;
	
	
	
	@GetMapping("/usuarios/{nombreDT}/{password}")
    def DT usuarios(@PathVariable String nombreDT,@PathVariable String password) {
     	
     	val usuarios = LigaMaster.instance.listaDT
		val usuario = usuarios.findFirst[u | u.getNombreDT.toLowerCase.equals(nombreDT.toLowerCase) && u.getPassword.equals(password)]
		//TODO: Tirar excepción si no lo encuentra.
		
		
        usuario
    }
    
    @RequestMapping(method = RequestMethod.GET, path = "/busqueda/{nombre}")
    def List<Jugador> getBusqueda(@PathVariable String nombre) {
     	val jugadores = SoFifa.instance.getJugadores(nombre)
		
        jugadores
    }
    
    @RequestMapping(method = RequestMethod.GET, path = "/dt/{nombreDT}")
    def getDT(@PathVariable String nombreDT) {
     	val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
    	ResponseEntity.ok(dt)
    }
    
	@RequestMapping(method = RequestMethod.GET, path = "/dts")
    def getDTs() {
     	val dts = LigaMaster.instance.listaDT.sortBy[nombreDT]
    	ResponseEntity.ok(dts)
    }
    
    @RequestMapping(method = RequestMethod.GET, path = "/torneos")
    def getTorneos() {
     	val torneos = LigaMaster.instance.listaTorneos
    	ResponseEntity.ok(torneos)
    }
    
    @RequestMapping(method = RequestMethod.GET, path = "/ofertas/recibidas/{nombreDT}")
    def getOfertas(@PathVariable String nombreDT) {
     	val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
		val ofertas = LigaMaster.instance.mercado.getOfertasRecibidas(dt)
    	ofertas
    }
    
    @RequestMapping(method = RequestMethod.GET, path = "/transferencias")
    def getTraspasos() {
     	val traspasos = LigaMaster.instance.mercado.listaTraspasos
     	traspasos
    }
}











//	 def static void main(String[] args) {
//        SpringApplication.run(MasterController, args);
//    }
//	def static void main(String[] args) throws Exception {
//        SpringApplication.run(MasterController, args);
//    }
