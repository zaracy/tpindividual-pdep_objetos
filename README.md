# PDEP Entertainment - TP Objetos

**Alumno:** Ángel Zaracho
**Curso:** K2001 (Lunes Mañana)  

## Justificaciones teoricas del TP

1. **Polimorfismo:** Lo aplique en las clases de las bandas (`BandaRock`, `BandaTrap`, `BandaIndie`) para los mensajes `presupuesto()` y `popularidad()`, y tambien en los abonos (`abonoFan` y `AbonoVip`) con el mensaje `descuento()`. Gracias a esto, la productora y el asistente pueden tratar a los objetos de forma transparente sin andar preguntando de que clase son.
2. **Encapsulamiento:** Las variables de estado del `Asistente` (como el dinero disponible o la lista de entradas) estan protegidas y no se modifican directamente desde afuera. Todo el manejo del saldo y la asignacion de la entrada se hace dentro del metodo `comprarEntrada()`, validando que tenga saldo suficiente antes de hacer la compra.
3. **Delegación y Estrategia:** El `Asistente` le delega al objeto `abono` el calculo del descuento a traves de `abono.descuento()`. Con esto evitamos meter logica que no le corresponde al asistente y nos permite cambiar o agregar tipos de abonos sin romper la clase `Asistente`.
4. **Herencia y Redefinicion:** La clase abstracta `Banda` agrupa el comportamiento comun (como el canon por defecto y la formula base de presupuesto). Despues cada subclase redefine o extiende lo que necesita, como los gastos extras o la popularidad segun sus propias reglas.
5. **Colecciones y Bloques:** Use bastante los metodos de colecciones de Wollok (`filter`, `map`, `sum`, `max`, `count`) pasandoles bloques. Por ejemplo en `productora` para calcular la ganancia total o buscar la banda mas popular, y en `Asistente` para saber las entradas del año anterior o obtener los nombres de las bandas que compro.