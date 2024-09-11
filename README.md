# Tom y Jerry

## Primera parte
Necesitamos modelar en Wollok a tom que es un gato.
Lo que nos interesa de tom es manejar su energía y su velocidad, que dependen de sus actividades de comer ratones y de correr. 
La persona que registra las actividades de tom, registra los ratones que come y la cantidad de tiempo que corre en segundos.

Cuando tom come un ratón aumenta su energía en 12 joules + el peso del ratón en gramos + 10 joules extra si el ratón está feliz.

La velocidad de tom es 5 metros x segundo + (energia medida en joules / 10). La velocidad que se toma es la que corresponde a la energía de Tom antes de empezar a correr, y no varía durante una carrera. 

Cuando tom corre, su energía disminuye en (0.5 x cantidad de metros que corrió). Observar que la cuenta está en joules consumidos por metro, pero cuando me dicen cuánto corrió, me lo dicen en segundos.

Nota: además de tom, hay otros objetos en juego, ¿cuáles son, qué mensaje tienen que entender?

Jerry es un ratón que tiene un peso que se encuentra relacionado a la cantidad de cosas que comió: El peso del ratón es de 30 gramos de base + el doble de la cantidad de letras que tiene cada alimento "pesado" que ingirió. Los alimentos "pesados" son los de más de 4 letras. Por ejemplo si comió "ensalada", "pan" y "churrasco" son 30 (de base) + 16 (de ensalada) + 18 (de churrasco) = 64 gr.

Jerry está feliz si alguno de los alimentos que comió es "pan". 

Mickey es otro ratón que su peso es de 15 gramos y está elgre si el gato que lo quiere comer es su gato favorito Tom.


## Segunda parte
Lograr que tom entienda el mensaje:
tom.meConvieneComerRatonA(unRaton, unaDistancia)
Se cumple si la energía que gana por comer al ratón es mayor a la que consume corriendo la distancia, que está medida en metros.