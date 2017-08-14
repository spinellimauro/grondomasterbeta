package controller

import datos.Precios
import datos.SoFifa
import master.LigaMaster
import master.Oferta
import master.Transferencia
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import org.springframework.web.bind.annotation.RestController
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.RequestMapping
import java.util.List
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.autoconfigure.EnableAutoConfiguration

@RestController
@EnableAutoConfiguration
class MasterController {
	
	
	
//	@Autowired
//   	Data data;
	
	@RequestMapping(method = RequestMethod.GET, path = "/usuarios/{nombreDT}/{password}")
    def usuarios(@PathVariable String nombreDT, String password) {
     	val usuarios = LigaMaster.instance.listaDT
		val usuario = usuarios.findFirst[u | u.getNombreDT.toLowerCase.equals(nombreDT.toLowerCase) && u.getPassword.equals(password)]
		//TODO: Tirar excepción si no lo encuentra.
		
		usuario
    }
//	 def static void main(String[] args) {
//        SpringApplication.run(MasterController, args);
//    }
//	def static void main(String[] args) throws Exception {
//        SpringApplication.run(MasterController, args);
//    }
}
