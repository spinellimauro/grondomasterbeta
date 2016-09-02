package master

import org.eclipse.xtend.lib.annotations.Accessors

import java.io.FileWriter
import java.io.BufferedWriter
import java.io.PrintWriter
import java.io.File

@Accessors
class Regla {
	double valorSlot = 10000  
	
	def void escribir(){

		val f = new File("nombre.txt")

	
		val w = new FileWriter(f)
		
		val bw = new BufferedWriter(w)
		
		val wr = new PrintWriter(bw)  
		
		wr.write("Esta es una linea de codigo")//escribimos en el archivo
		
		wr.append(" - y aqui continua") //concatenamos en el archivo sin borrar lo existente
		
		        //ahora cerramos los flujos de canales de datos, al cerrarlos el archivo quedará guardado con información escrita
		bw.close()
 		
	 }
 } 



