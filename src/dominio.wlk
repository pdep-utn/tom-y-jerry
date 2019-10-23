class Gato {

	var property energia = 100
	const energiaBaseQueAumentaAlComer = 12
	const velocidadBase = 5
	const coeficienteDeEnergiaAlCorrer = 0.5

	method comer(unRaton) {
		const energiaPorComer = energiaBaseQueAumentaAlComer + unRaton.peso()
		return new Gato(energia = energia + energiaPorComer) 
	}

	method velocidad() {
		const coeficienteDeEnergiaParaVelocidad = 10
		return velocidadBase + energia / coeficienteDeEnergiaParaVelocidad
	}

	method correr(segundos) {
		const metros = self.velocidad() * segundos
		const energiaPorCorrer = metros * coeficienteDeEnergiaAlCorrer 
		return new Gato(energia = energia - energiaPorCorrer)
	}

	method tieneMasEnergiaQue(otroGato) = energia > otroGato.energia() 
	
	method meConvieneComerRatonA(unRaton, unaDistancia) = self.comer(unRaton).tieneMasEnergiaQue(self.correr(unaDistancia))

}

object jerry {

	var property peso = 100

}

object juan {

	var property peso = 100

}

object mickey {

	method peso() = 44

}

