# Resolución del ejercicio de Tom y Jerry

## Enunciado 
### Parte A
Implementar en Wollok un objeto que represente a **tom**, que es un gato.


Lo que nos interesa de tom es manejar su energía y su velocidad, que dependen de sus actividades de comer ratones y de correr. 

La persona que registra las actividades de tom, registra los ratones que come y la cantidad de tiempo que corre en segundos. Cuando tom come un ratón, su energía aumenta en (12 joules + el peso del ratón en gramos). La velocidad de tom es 5 metros x segundo + (energia medida en joules / 10). 

Cuando tom corre, su energía disminuye en (0.5 x cantidad de metros que corrió). Observar que la cuenta está en joules consumidos por metro, pero cuando me dicen cuánto corrió, me lo dicen en segundos. La velocidad que se toma es la que corresponde a la energía de Tom antes de empezar a correr, y no varía durante una carrera.

**Nota** Además de tom, hay otros objetos en juego, ¿cuáles son, qué mensaje tienen que entender?

### Parte B
Lograr que tom entienda el mensaje:
*tom.meConvieneComerRatonA(unRaton, unaDistancia)* que 
devuelve **true** si la energía que gana por comer al ratón es mayor a la que consume corriendo la distancia, que está medida en metros.

---
## Manos a la obra, ¿cómo arrancamos?

Lo primero que podemos hacer es pensar en que **objetos candidatos** tenemos, es decir que abstracciones podría llegar a crear a partir del requerimiento.

> Lo que nos interesa de tom es manejar su energía y su velocidad, que dependen de sus actividades de comer ratones y de correr. 

Rápidamente aparece la idea de modelar a tom como un objeto. Es un buen punto de partida.

```wollok
object tom {

}
```
## Entendiendo el mensaje
Bien, ¡excelente! ya tenemos un objeto. Por otra parte dice que tenemos que manejar su energía y su velocidad que dependen de actividades como comer ratones y de comer. Nos da una idea de lo que puede ser un atributo y lo que puede ser un método. Pero vamos despacio y sin apuro. Lo primero que tenemos que pensar es en que mensajes debería entender nuestro objeto que representa a Tom. Leamos un poco más del requerimiento:

> Cuando tom come un ratón, su energía aumenta en (12 joules + el peso del ratón en gramos)

mmm, ok. Necesitamos que tom entienda el mensaje comer a un ratón. Por lo tanto podemos escribir el método en el objeto para luego describir el comprotamiento que va a tener. Entonces: 
```wollok
object tom {

  method comer(){}
}
```
## Mensaje recibido... ¿y ahora?
Nos dice que su energía debe aumentar en 12 joules + el peso del ratón en gramos. Acá se desprenden varios interrogantes:
- ¿Cómo modelo la energía? como un objeto :P (¡cuac!). Si, pero ...¿cuál? ¿Un String? ¿un Number? ¿Me debería importar?
- ¿Cómo se el peso del ratón? ¿Ya lo conozco de antes? ¿Se lo paso como parámetro? ¿Solo el peso? ¿El ratón entero?
- ¿Tengo que devolver algo? ¿Tengo que hacer algo?

Lo primero que tenemos que hacer es saber responder esta última pregunta. Los métodos se dividen en dos grandes grupos: Los de **acción** y los de **consulta**.

1. **Acción** son los métodos que producen un cambio en el estado del objeto. Es decir, si yo tengo mi objeto con una referencia a otro objeto (por ejemplo un número: el 3), si alguien envía un mensaje cuyo método tiene el comprtamiento de cambiar dicha referencia por otro valor (podemos suponer para ej elemplo otro número: el 5) entonces se produce ese cambio de referencia **sin retornar valor alguno**. 
2. **Consulta** son los métodos que nos van a devolver un valor. Habitualmente depende del estado del objeto, aunque esto no ocurre siempre. Si nuestro método es de una sola línea podemos evitar el return y definir el contenido sin llaves, con el **=** y la expresión a evaluar (por ejemplo *method nombreDelMétodo() = expresiónAEvaluar*).

En este caso, ¿de qué tipo de método se trata? Es de acción, porque debemos incrementar su energía en un determinado valor. Ok, entonces sabemos que se incrementa en 12 joules + el peso del ratón. Veamos como traducimos eso a código
```wollok
object tom {

  method comer(){
    energia = energia + 12 + ¿...?
  }
}
```
Acá ya tomamos una decisión sin darnos casi cuenta. Acabamos de modelar la energía como un atributo de tom que claramente debe variar. ¿Cuándo? cuando le envían el mensaje de comer. Entonces pasamos a definir ese atributo. Pero tenemos dos caminos para elegir: podemos definirlo como una referencia variable que puede cambiar en el tiempo (explicitada con la palabra reservada **var**) o bien podemos definirlo como una referencia constante que se mantiene en todo el ciclo de vida de nuestro objeto (explicitada con la palabra reservada **const**). En este caso esa referencia debe ser variable, por lo que vamos a optar por un var.

```wollok
object tom {
  var energia = 0

  method comer(){
    energia = energia + 12 + ¿...?
  }
}
```

Por el momento y a fines didácticos nos vamos a tomar la libertad de inicializarla con el valor 0, de lo contrario el IDE nos va a marcar que no tenemos inicializada la variable energía. Esta es una decisión que no podemos tomar de forma deliberada como desarrolladores: podemos inicalizar un objeto en un estado que no es el esperado. ¿Cuál es la solución? comunicarse con el cliente y consultar.

Vamos a hacer foco en como obtenemos el peso del ratón. Veamos diferentes opciones

### Ratón, yo te conozco
Una de las alternativas es que tengamos una referencia al ratón, es decir que tom conozca al ratón. ¿Y qué mensaje le debería mandar al ratón para conocer su peso?
```wollok
object tom {
  var energia = 0
  var raton
  method comer(){
    energia = energia + 12 + raton.peso()
  }
}
```
Ok, esto funciona. Pero, ¿es una buena solución? Mmmm... en primer lugar tengo ratón sin referenciar, entonces necesitamos referenciar a jerry por ejemplo. Lo hacemos a travez de un método:
```wollok
object tom {
  var energia = 0
  var raton
  method comer(){
    energia = energia + 12 + raton.peso()
  }
  method raton(_aton){
    raton = _raton
  }
}
```
Este tipo de método de **acción** se conoce como **setter** porque "setea" una referenica del objeto. También podríamos tener un método de **pregunta** que nos devuelva el valor de la variable y estos se conocen como **getters**.
```wollok
object tom {
  var energia = 0
  var raton
  method comer(){
    energia = energia + 12 + raton.peso()
  }
  method raton(_aton){
    raton = _raton
  }
  method raton() = raton
}
```
Por convención en **Wollok** tomamos como getter o setter el método cuyo nombre es igual al del atributo que vincula. El par getter-setter podemos escribirlo de forma implícita agregando la palabra reservada **property**. Entonces nos quedaría
```wollok
object tom {
  var energia = 0
  var property raton
  method comer(){
    energia = energia + 12 + raton.peso()
  }
}
```
Como gran desventaja, cada vez que tenemos que enviar el mensaje de comer, antes nos tenemos que asegurar de que la referencia de ratón sea la correcta. Entonces tenemos que verificar o setear siemrpe antes de comer. Muy feo.

### ¿Cuanto pesás? 
Otra opción es que le pasemos el peso como parámetro, es decir que tengamos una referencia con un scope reducido al método que estamos modelando.
```wollok
object tom {
  var energia = 0

  method comer(peso){
    energia = energia + 12 + peso
  }
}
```
De esta forma eliminamos el problema de tener que estar verificando la referencia al ratón. Pero ahora tenemos que enviar un mensaje distinto al anterior: nuestro mensaje tiene un peso del ratón como parámetro. 

Entendemos que el peso del ratón en un número el cual podemos sumar. Eso parece tener todo el sentido del mundo en este caso pero no sabemos como es que el ratón modela a su peso...

### Que lo resuelva el ratón
Y esta tercera opción, que es la que entendemos como la que mejor se adapta al modelado, es que le pasemos la referencia al ratón y le preguntemos su peso
```wollok
object tom {
  var energia = 0

  method comer(raton){
    energia = energia + 12 + raton.peso()
  }
}
```
Si el ratón tiene una forma mucho más compleja de clacular su peso, o bien el peso es un objeto diferente a un number, deja de ser mi problema. Desde tom preguntamos al ratón que tenemos referenciado en la variable raton por su peso y es responsabildad de él calcularlo. Solo sabemos que esperamos un número como respuesta. De esta forma delegamos esa responsabilidad al ratón, desacoplamos al objeto de tom y a los ratones y mantenemos el encapsulamiento del comportamiento del ratón dentro del ratón.

Incluso podríamos mejorar la expresividad del método extrayendo le 12 como constante
```wollok
object tom {
  var energia = 0
  const energiaBase = 12 

  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
}
```

## Corre Tom, ¡corre!
Veamos ahora que más nos pide el requerimiento

>La persona que registra las actividades de tom, registra los ratones que come y la cantidad de tiempo que corre en segundos

y además 

> Cuando tom corre, su energía disminuye en (0.5 x cantidad de metros que corrió)

Entonces nuevamente tenemos que pensar que mensaje nos tiene que llegar a tom. Correr puede ser un buen nombre para el mensaje y recibe un tiempo que corre en segundos. Entonces :

```wollok
object tom {
  var energia = 0
  const energiaBase = 12 

  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {}
}
```

¡Bien! ya tenemos la interfaz, es decir la firma del método (que recibe, cómo se llama y qué devueve). Nuevamente estamos ante un método de **acción** porque tenemos que cambiar el estado del objeto, es decir que tenemos que disminuir su energía. 

```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const coeficienteDeEnergiaAlCorrer = 0.5
  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    energia = energia - coeficienteDeEnergiaAlCorrer * ???
  }
}
```

Mmmm, necesito la distancia pero recibo los segundos. Huuuu, ¡estamos al horno! pero si recordamos el enunciado 

> La velocidad que se toma es la que corresponde a la energía de Tom antes de empezar a correr, y no varía durante una carrera.

>La velocidad de tom es 5 metros x segundo + (energia medida en joules / 10)


Entonces podemos calcular esa longitud como la velocidad por el tiempo

```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const coeficienteDeEnergiaAlCorrer = 0.5
  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    energia = energia - coeficienteDeEnergiaAlCorrer * "velocidad" * segundos
  }
}
```

Que podemos extraerlo en una constante porque el espacio es calculable como es a velocidad * tiempo
```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const coeficienteDeEnergiaAlCorrer = 0.5
  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    const espacio = "velocidad" * segundos
    energia = energia - coeficienteDeEnergiaAlCorrer * espacio
  }
}
```

Ahora... ¿Cómo se calcula esa "velocidad"? Nuevamente sacamos a las pistas las comparaciones de opciones

### Que tom tenga un atributo velocidad

```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const velocidadBase = 5
  const coeficienteDeEnergiaAlCorrer = 0.5
  const coeficienteDeEnergiaParaVelocidad = 10
  var velocidad = velocidadBase + energia / coeficienteDeEnergiaParaVelocidad

  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    const espacio = velocidad * segundos
    energia = energia - coeficienteDeEnergiaAlCorrer * espacio
  }
}
```
No suena bien. ¿Por qué? porque cuando iniciamos nuestra VM de wollok se reduce esa expresión que calcula la velocidad en una primera instancia y referencia mediante el atributo velocidad a un valor, por ejemplo 50. 

### Que tom tenga un atributo velocidad pero lo calculemos en un método
Ok, entonces calculemos en otra parte
```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const velocidadBase = 5
  const coeficienteDeEnergiaAlCorrer = 0.5
  const coeficienteDeEnergiaParaVelocidad = 10
  var velocidad

  method calcularVelocidad() {
    velocidad = velocidadBase + energia / coeficienteDeEnergiaParaVelocidad
  }
  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    this.calcularVelocidad()
    const espacio = velocidad * segundos
    energia = energia - coeficienteDeEnergiaAlCorrer * espacio
  }
}
```
Ok, generamos un método cohesivo que se encarga de asignar el valor correspondiente a la velocidad. Pero pueden notar que debo siempre invocar al método **this.calcularVelocidad()** para que quede referenciada la velocidad que necesito. Si la velocidad estuviese utilizada desde otros métodos voy a tener que **siempre** llamar antes a este método repitiendo esta lógica a lo largo de todo el objeto. 

Otro problema que nos trae es que vamos a suponer que para un tom cuyo estado tiene energía de 10, su velocidad 0 y queremos que corra 1 segundo. Cuando calculo su velocidad es de 6 (5 + 10/10). Entonces energía que estaba referenciando al objeto 10, va a bajar en 0.5 * 6 * 1 segundo, es decir que va a quedar en 7. Si miramos el objeto tom, encontramos que tiene energía 7 y velocidad de 6. Este estado es **incoherente** porque para una energía de 7 unidades no puede tener velocidad de 6.

Entonces la pregunta es ¿Debería formar parte del estado la velocidad?

### Atributo calculado
Nos encontramos que este atributo es un valor calculable a partir de otro. Es decir que la velocidad **depende** de la energía que tenga. Por lo tanto delegamos el cálculo completo en un método de pregunta
```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const velocidadBase = 5
  const coeficienteDeEnergiaAlCorrer = 0.5
  const coeficienteDeEnergiaParaVelocidad = 10

  method velocidad() = velocidadBase + energia / coeficienteDeEnergiaParaVelocidad
  
  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    this.calcularVelocidad()
    const espacio = this.velocidad() * segundos
    energia = energia - coeficienteDeEnergiaAlCorrer * espacio
  }
}
```
Ahora cada vez que enviamos el mensaje velocidad() vamos a obtener el valor correspondiente al cálculo para la energía que pertenece al estado actual del objeto tom. 

## Parte B
El enunciado dice 

>Lograr que tom entienda el mensaje:
*tom.meConvieneComerRatonA(unRaton, unaDistancia)* que 
devuelve **true** si la energía que gana por comer al ratón es mayor a la que consume corriendo la distancia, que está medida en metros.

Ya nos dan el mensaje que tenemos que recibir, por lo tanto empezamos a codificar el método

```wollok
object tom {
  var energia = 0
  const energiaBase = 12 
  const velocidadBase = 5
  const coeficienteDeEnergiaAlCorrer = 0.5
  const coeficienteDeEnergiaParaVelocidad = 10

  method velocidad() = velocidadBase + energia / coeficienteDeEnergiaParaVelocidad
  
  method comer(raton){
    energia = energia + energiaBase + raton.peso()
  }
  method correr(segundos) {
    this.calcularVelocidad()
    const espacio = this.velocidad() * segundos
    energia = energia - coeficienteDeEnergiaAlCorrer * espacio
  }

  meConvieneComerRatonA(unRaton, unaDistancia) {}
}
```

¿Es de pregunta o acción? Claramente es de pregunta porque me tiene que dar true si le conviene. Entonces no tiene que producirse un cambio en el estado de tom.