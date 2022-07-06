import minions.*

class Ciudad{
	var nombre
	var property temperatura
	var objetivos = []
}
class Villanos{
	var property minions = []
	var property ciudad  
	
	method nuevoMinion(){
		minions.add(new Minions(bananas=5, estado = amarillo, armas = [new Armas(potencia = 10, nombre = "Rayo congelante")]))	
	}
	method otorgarArmas(minion,arma){
		minion.armas().add(arma)
	}
	method alimentar(minion,cantidad){
		minion.alimentar(cantidad)	
	}
	method nivelDeConcentracion(minion){
		return minion.concentracion(minion)
	}
	method esPeligroso(minion){
		return minion.peligroso()
	}
	method tomarSueroMutante(minion){
		minion.absorciondeSueroMutante(minion)
	}
	method contadorDeMaldades(minion) = minion.sumoUnaMaldad()
	
	method minionMasUtil(){
		minions.max{minion => minion.cantidadDeMaldades()}
	}
	method minionsMasInutiles(){
		minions.filter{minion => minion.cantidadDeMaldades() == 0}
	}
}

class Maldades{
	var villano = new Villano(ciudad = new Ciudad(nombre = Campana ,temperatura = 80 ))
	var minionsCapaces = []
	//var tipoMaldad
	
	method buscoMinionsParaMaldad(){}
	method premio(){}
	method contador(){
		minionsCapaces.forEach{minion=>villano.contadorDeMaldades(minion)}
	}
}

class Congelar inherits Maldades(){
	var concentracion = 500
	
	
	override method buscoMinionsParaMaldad(){
		minionsCapaces = (villano.minions().filter{minion=>(minion.armas().filter{arma=>arma.nombre() == "Rayo congelante"}).size()>0 and (villano.nivelDeConcentracion(minion) == 500)})
	}
	override method premio(){
		villano.ciudad().temperatura(-30)////noseeeeeee
		minionsCapaces.forEach{minion=> villano.alimentar(minion,10)}
	}
}

class Robos inherits Maldades{
	
	var objetivo 
	
	override method buscoMinionsParaMaldad(){
		minionsCapaces = objetivo.buscoMinionsConcentracion().map{minion=>villano.esPeligroso(minion)}
	}
	override method premio(){
		objetivo.recompensa()
	}
}
	
class Piramides inherits Robos (objetivo = self){
	var altura
	
	method buscoMinionsConcentracion(){
		return villano.minions().filter({minion=> villano.nivelDeConcentracion(minion) >= (altura/2)})
	}
	method recompensa(){
		minionsCapaces.forEach{minion=> villano.alimentar(minion,10)}
	}
}
object sueroMutante inherits Robos (objetivo = self) {
	method buscoMinionsConcentracion(){
		return villano.minions().filter({minion=> minion.bananas()> 100 and villano.nivelDeConcentracion(minion) <= 23})
	}
	method recompensa(){
		minionsCapaces.forEach{minion=> villano.tomarSueroMutante(minion)}
	}
}
object luna inherits Robos (objetivo = self){
	method buscoMinionsConcentracion(villano){
		return villano.minions().forEach({minion=> (minion.armas().filter{arma=>arma == "rayo para encoger"})})
	}
	method recompensa(){
		minionsCapaces.forEach{minion=>villano.otorgarArmas(minion, new Armas(nombre = "Rayo Congelante" , potencia = 10))}
	}
}