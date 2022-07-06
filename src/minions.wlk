class Armas {
	var property potencia
	var property nombre
}

class Minions {
	var property bananas
	var property armas = []
	var property estado = amarillo
	var property cantidadDeMaldades = 0 
	
	method agregarArma(arma){
		armas.add(arma)
	}
	
	method alimentar(cantidad){
		bananas += cantidad
	}	
	
	method peligroso(){
		return (armas.size() >= 2)	
	}
	method absorciondeSueroMutante(minion){
		bananas = (bananas - 1).max(0)
		estado.absorciondeSueroMutante(minion)
	}
	
	method concentracion(minion) = estado.concentracion(minion)
	
	method sumoUnaMaldad(){
		cantidadDeMaldades += 1
	}
}

object violeta{
	method absorciondeSueroMutante(minion){
		minion.estado(amarillo)
	}
	
	method concentracion(minion){
		return  minion.bananas()
	}	
}

object amarillo{
	method absorciondeSueroMutante(minion){
		minion.armas().clear()
		minion.estado(violeta)
	}
	
	method concentracion(minion){
		return minion.armas().max{arma=> arma.potencia()}.potencia() + minion.bananas()
	}
	
}



