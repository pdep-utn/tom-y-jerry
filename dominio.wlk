object tom {

	var energia = 100
	const energiaBaseQueAumentaAlComer = 12
	const velocidadBase = 5
	const coeficienteDeEnergiaAlCorrer = 0.5
	const coeficienteDeEnergiaParaVelocidad = 10

	method comer(unRaton) {
		energia = energia + self.energiaPorComer(unRaton)
	}

	method energiaPorComer(unRaton) = energiaBaseQueAumentaAlComer + unRaton.peso()

	method velocidad() = velocidadBase + energia / coeficienteDeEnergiaParaVelocidad

	method correr(segundos) {
		const metros = self.velocidad() * segundos
		energia = energia - self.energiaPorCorrer(metros)
	}

	method energiaPorCorrer(metros) = metros * coeficienteDeEnergiaAlCorrer

	method meConvieneComerRatonA(unRaton, unaDistancia) = self.energiaPorComer(unRaton) > self.energiaPorCorrer(unaDistancia)

}
	
object jerry {
	var property peso = 100
}

object mickey {
	method peso() = 44
}

