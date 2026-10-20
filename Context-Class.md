Escenarios de modificabilidad

Nota
En los dos, el ambiente es de desarrollo, aunque el sistema esté en producción mientras tanto. La modificabilidad es un atributo de tiempo de desarrollo: lo que se juzga es el trabajo de cambiar el sistema, y ese trabajo ocurre en desarrollo. Lo que sí varía, y cambia el costo, es en qué momento se liga el cambio: en el código, en la compilación, en el despliegue o en la ejecución. “En operación normal” es el ambiente típico de los atributos de tiempo de ejecución, como el desempeño o la disponibilidad.

Idea clave
Fíjate en las dos formas de medir. La primera usa horas-hombre (el costo directo); la segunda usa número de componentes afectados (la propagación). La segunda es la más arquitectónica: mide qué tan contenido quedó el cambio. “Componentes afectados = 1” no es suerte —el escenario de Envíos aclara por qué: está desacoplado de los demás y se comunica por un conector publicador-suscriptor—. La medida delata la táctica.

Tip
Un buen escenario de modificabilidad hace explícito el cambio previsible. No se puede diseñar para “cualquier cambio” —eso lleva a sobre-ingeniería, a abstraer todo por si acaso—. Se diseña para los cambios probables: si el negocio va a internacionalizarse, ese cambio merece una barrera; si nunca va a cambiar de moneda, encapsularla es esfuerzo desperdiciado. El escenario es donde se declara qué apuesta vale la pena.

Idea clave
La medida delata lo que el arquitecto espera de la estructura. “Componentes tocados = 1” en el adaptativo es una promesa de diseño: dice que existe una barrera entre Pagos y cada banco. Si el escenario se escribe así y la arquitectura no tiene esa barrera, el escenario no se cumple, y eso es exactamente lo que una evaluación de arquitectura debe encontrar.

Advertencia
Cuidado con la medida “tiempo de desarrollo” a secas en escenarios aditivos: depende del tamaño de la función, del equipo y de mil factores que no son arquitectura. Combínala siempre con una medida de estructura —cuántos módulos existentes hay que modificar, cuántas interfaces cambian—, que sí es responsabilidad del diseño.

Acoplamiento, cohesión y encapsulamiento

Idea clave
La modificabilidad no se mide en abstracto: se mide en la propagación. Un cambio que toca un componente es barato y de bajo riesgo; el mismo cambio que obliga a tocar cinco es caro y peligroso —cada componente tocado es una oportunidad de romper algo—. Todo el diseño para la modificabilidad busca lo mismo: que los cambios previsibles queden contenidos.

No todo acoplamiento es igual

Tipo	Qué comparten	En Pagora	Qué cambio lo rompe
De contenido	Uno entra en las entrañas del otro	Antifraude lee directamente la tabla interna de Cuentas	Cualquier cambio interno de Cuentas
Común	Un estado global que los dos leen y escriben	Una caché compartida de saldos que todos modifican	Quien la escriba distinto rompe a los demás
Externo	Un formato o protocolo impuesto desde afuera	Dos módulos que parsean el mismo archivo plano del banco	Que el banco cambie el formato
De control	Uno le dice al otro cómo hacer su trabajo	Pagos llama liquidar(pago, modo=3) y Contabilidad hace un switch por el modo	Agregar un modo nuevo toca a los dos
De estampado	Una estructura entera, aunque se use una parte	Notificaciones recibe el objeto Pago completo para usar solo el correo	Cualquier cambio en la estructura del pago
De datos	Solo los datos que se necesitan, como parámetros	Notificaciones recibe destinatario y mensaje	Solo un cambio en esos datos

Tip
La tabla sirve como lista de revisión en una evaluación de arquitectura. Los tres primeros tipos casi nunca se justifican entre componentes de negocio: son la causa típica de que un cambio “local” termine tocando medio sistema. Los dos últimos son el acoplamiento normal de cualquier sistema; el de estampado se vuelve problema cuando la estructura compartida cambia seguido.

Connascence: un vocabulario más fino

 la connascence —literalmente, “nacer juntos”—: dos elementos son connascentes si un cambio en uno obliga a cambiar el otro para que el sistema siga correcto

 Forma	Los dos elementos deben acordar…	Ejemplo en Pagora
Nombre (estática)	El nombre de algo	Pagos llama autorizar() en la pasarela
Tipo (estática)	El tipo de un dato	El monto es un decimal y no un flotante
Significado (estática)	El significado de un valor	Que el estado 3 quiere decir “rechazado”
Posición (estática)	El orden de los parámetros	transferir(origen, destino, monto) en ese orden
Algoritmo (estática)	El mismo algoritmo en los dos lados	El cálculo del dígito de verificación, duplicado en la app y en el servidor
Ejecución (dinámica)	El orden en que ocurren las cosas	Reservar el saldo antes de llamar al banco
Tiempo (dinámica)	Cuándo ocurren	El banco responde antes de 30 segundos o la reserva vence
Valor (dinámica)	Valores que deben ser consistentes	La suma de los asientos de un pago debe dar cero
Identidad (dinámica)	Referirse al mismo objeto	Pagos y Contabilidad deben hablar del mismo pago, no de una copia

Medir el acoplamiento: inestabilidad y abstracción

El acoplamiento también se puede contar. La idea es mirar la dirección de las flechas de dependencia de cada módulo. Tomemos el monolito modular de Pagora, donde “A → B” quiere decir que A usa a B:

Pagos → Cuentas, Antifraude, Pasarelas, Notificaciones y Contabilidad
Antifraude → Cuentas
Contabilidad → Cuentas
Para cada módulo, Martin propone tres números (Martin, 2003):

Acoplamiento aferente (Ca): las flechas que llegan. “Aferente” quiere decir “que viene hacia”. Cuentas recibe tres flechas —de Pagos, Antifraude y Contabilidad—, así que Ca = 3: si Cuentas cambia lo que ofrece, tres módulos se enteran. Ca mide la responsabilidad del módulo hacia los demás.
Acoplamiento eferente (Ce): las flechas que salen. “Eferente” quiere decir “que va hacia afuera”. De Pagos salen cinco flechas, así que Ce = 5: si cualquiera de esos cinco cambia, Pagos se puede romper. Ce mide la exposición del módulo a cambios ajenos.
Inestabilidad: I = Ce / (Ca + Ce), la proporción de las flechas del módulo que son de salida. Va de 0 a 1.

Módulo	Ca (llegan)	Ce (salen)	I	Qué dice
Cuentas	3	0	0 / 3 = 0	Todos dependen de él y él de nadie
Antifraude	1	1	1 / 2 = 0,5	Tanto depende como dependen de él
Pagos	0	5	5 / 5 = 1	Depende de todos y nadie depende de él

Advertencia
La alerta no es I = 0: es I = 0 con código concreto. Un módulo estable debería contener lo que casi nunca cambia —interfaces, contratos, los conceptos del dominio que duran años—. Si en cambio tiene lógica concreta que sí cambia, como el cálculo del saldo disponible dentro de Cuentas, queda atrapado: o no se cambia y se acumula deuda, o se cambia y se arriesga romper a los tres que lo usan. La salida no es bajarle el Ca —que otros lo usen está bien—, sino subirle la abstracción: que dependan de una interfaz estable de Cuentas y no de su código.

El encapsulamiento: la barrera al cambio

Advertencia
El encapsulamiento no es gratis, y bajar la propagación puede subir el acoplamiento. En el ejemplo de la moneda, centralizar todo en un componente de Internacionalización hace que un cambio de moneda toque un solo sitio —pero ahora Catálogo, Carro y Pagos dependen los tres de ese nuevo componente—. Y dividir en módulos más pequeños mejora la cohesión, pero añade comunicación entre ellos (más latencia). No hay bala de plata: hay tradeoffs que se eligen sabiendo qué cambios son los probables.

Tipos de cambio y como modificarlos

Tip
Este eje conecta directo con las tácticas. Lo que viene de terceros pide aislarlos detrás de un adaptador; lo que viene del negocio pide que las reglas cambien sin tocar el flujo (estrategias, reglas como datos); lo que viene de la tecnología propia pide no depender de ella en el núcleo. La lección de patrones vuelve sobre esta correspondencia.

Eje 3 · Cuánto de la estructura toca: el alcance

Idea clave
El alcance no es una propiedad del cambio, es una propiedad del cambio frente a una arquitectura. Agregar un banco es local en una Pagora con interfaz de pasarelas y no local en una Pagora donde cada banco está cableado dentro de Pagos. Por eso este es el eje que el arquitecto puede mover: el objetivo del diseño para la modificabilidad es que los cambios probables sean locales.

Tacticas de modificabilidad

ideas clave
Encapsular e intermediar atacan el acoplamiento desde ángulos distintos. Encapsular oculta el cómo (la implementación) detrás de un API: protege de los cambios internos. Un intermediario oculta el quién (la identidad del otro componente): protege de los cambios en con quién se habla. Envíos usa las dos: expone poco (encapsula) y escucha una cola sin saber quién publica (intermediario). Por eso su cambio no afectó a nadie.

SOLID y Clean Architecture

SOLID: las tácticas a escala de módulo
Principio	Qué dice	Táctica que expresa	En Pagora
S · Responsabilidad única	Un módulo responde a un solo actor: un solo grupo de personas que puede pedirle cambios	Aumentar la cohesión	El cálculo de comisiones (que pide Finanzas) no vive en el mismo módulo que el formato del recibo (que pide Mercadeo)
O · Abierto/cerrado	Abierto a la extensión, cerrado a la modificación: lo nuevo se agrega, no se edita	Diferir el binding; polimorfismo	Un banco nuevo es una clase nueva que implementa IPasarela; Pagos no se edita
L · Sustitución de Liskov	Cualquier implementación de una abstracción debe poder usarse donde se espera la abstracción, sin sorpresas	Encapsular (el contrato es la barrera)	Si el adaptador del Banco C lanza una excepción que los otros no lanzan, Pagos termina preguntando “¿es el Banco C?”: vuelve el acoplamiento
I · Segregación de interfaces	Ningún cliente debe depender de operaciones que no usa	Restringir dependencias	Notificaciones depende de una interfaz con enviar(), no de la interfaz entera de Pagos
D · Inversión de dependencias	Las políticas de alto nivel no dependen de los detalles; los dos dependen de abstracciones	Abstraer servicios comunes; reducir acoplamiento	ConfirmarPago depende de IPasarela; el adaptador del banco también. Ninguno conoce al otro

Clean architecture: la regla de dependencia

Llevados a la forma de todo el sistema, estos principios producen lo que Martin llama Clean Architecture: círculos concéntricos donde el centro es el negocio y la periferia es la tecnología.

Entidades: las reglas del negocio que existirían aunque no hubiera sistema. El pago, la comisión, el límite diario.
Casos de uso: las reglas propias de esta aplicación. Confirmar un pago, reversarlo.
Adaptadores de interfaz: convierten entre el formato del caso de uso y el del mundo exterior. Controladores, repositorios, el adaptador de cada banco.
Frameworks y drivers: los detalles. El framework web, la base de datos, el SDK del banco.
Y una sola regla las gobierna: las dependencias de código fuente solo apuntan hacia adentro.

Advertencia
El error más común al adoptar Clean Architecture no es aplicarla mal, sino aplicarla entera a todo: cuatro capas y tres mapeos para mostrar una tabla de parámetros. Eso es sobre-ingeniería en el sentido exacto de la lección de tipos de cambio: invertir en una barrera contra un cambio que nunca va a llegar.

Patrones y codigo limpio.

Olores que delatan el problema 

Fowler llama olores de código a los síntomas que no son errores pero indican que el diseño está cediendo (Fowler, 2018). Varios son, literalmente, problemas de modificabilidad descritos desde el código:

Olor	Cómo se ve	Qué dice en términos del capítulo
Cambio divergente	Un mismo módulo se edita por razones que no tienen nada que ver entre sí	Baja cohesión: responde a varios actores
Cirugía de escopeta	Un cambio pequeño obliga a editar muchos módulos a la vez	Alta propagación: la medida del capítulo, vista en un commit
Código duplicado	La misma lógica en varios lugares	Connascence de algoritmo que cruza fronteras
Switch repetido	El mismo condicional por tipo en varios sitios	Falta un Strategy o un polimorfismo
Envidia de funcionalidad	Un módulo usa más los datos de otro que los propios	La responsabilidad está en el lugar equivocado
Obsesión por primitivos	Montos, monedas y estados como números y textos sueltos	Connascence de significado
Cadenas de mensajes	pago.cuenta().titular().direccion().ciudad()	Acoplamiento a la estructura interna de otros
Generalidad especulativa	Interfaces y parámetros para casos que nunca llegaron	Sobre-ingeniería: una barrera contra un cambio improbable

Tip
Cambio divergente y cirugía de escopeta son espejos y conviene enseñarlos juntos. En el primero, un módulo cambia por muchas razones: hay que partirlo. En el segundo, una razón cambia muchos módulos: hay que juntar. El acoplamiento de cambio de la primera lección es la forma de encontrar la cirugía de escopeta en un sistema grande sin leer el código: los archivos que siempre aparecen juntos en los commits.

Código limpio: la defensa contra la segunda ley de Lehman

La segunda ley de Lehman dice que la complejidad crece salvo que se invierta trabajo explícito en contenerla. Las prácticas de código limpio son ese trabajo, repartido en dosis pequeñas en cada cambio (Martin, 2008):

Nombres que revelan intención: comisionPorCategoria, no calc2. Un nombre preciso es la forma más débil —y más barata— de connascence.
Funciones pequeñas, con un solo nivel de abstracción: la que decide si un pago procede no debería también armar el SQL.
Sin efectos secundarios escondidos: una función que se llama validar no debería también reservar el saldo.
Una sola representación de cada conocimiento: la comisión se calcula en un lugar.
La regla del boy scout: dejar cada módulo un poco más limpio de lo que se encontró. Es la forma de pagar la deuda técnica sin pedir un proyecto aparte.

Advertencia
El código limpio no reemplaza la arquitectura, y la arquitectura no reemplaza el código limpio. Un sistema con puertos y adaptadores impecables puede ser imposible de cambiar si cada adaptador es una función de 600 líneas; un código pulcro dentro de un diseño donde todo depende de todo sigue propagando cada cambio. La modificabilidad necesita las dos escalas.

Integración e interoperabilidad

Idea clave
La idea que une el capítulo: integrar es cerrar una distancia entre interfaces —y esa distancia tiene cinco caras (sintáctica, semántica en datos y comportamiento, temporal, de recursos)—. Casi siempre se integra con componentes que no controlamos (la API de un banco, una librería), así que integrar es, en el fondo, negociar contratos y planificar el cambio con información incompleta.

Contratos, adaptadores y mediadores

Advertencia
La distancia sintáctica es la fácil; las semánticas son las que muerden. Que los tipos coincidan (sintáctica) lo atrapa el compilador. Pero que un “1500” signifique lo mismo para los dos (semántica en datos), o que ambos sepan quién reintenta ante un error (semántica en comportamiento) —eso no lo atrapa nadie hasta que el pago sale mal en producción—. Un contrato de integración serio declara las cinco distancias, no solo la firma de la función.

Las tácticas de integrabilidad

Familia	Táctica	Qué hace	En Pagora
Limitar dependencias	Encapsular	Ofrecer una interfaz explícita y esconder el resto	Pagos expone una API y no deja leer sus tablas
Usar un intermediario	Romper la dependencia directa entre los dos lados	Un bus de eventos entre Pagos y los interesados
Restringir las rutas de comunicación	Limitar con quién puede hablar cada componente	Solo el módulo de Pasarelas habla con los bancos
Adherirse a estándares	Usar formatos y protocolos que el otro ya conoce	Mensajes ISO 20022 con los bancos
Abstraer servicios comunes	Una interfaz común para servicios parecidos	IPasarela para todos los bancos
Adaptar	Descubrir	Encontrar el servicio en ejecución	La pasarela vigente se busca en un registro
Ajustar la interfaz	Agregar o esconder capacidades sin tocar el componente	Un adaptador que traduce el formato del Banco A
Configurar el comportamiento	Cambiar cómo se comporta según con quién habla	Tiempos de espera y reintentos distintos por banco
Coordinar	Orquestar	Un componente dirige la secuencia de los demás	Un orquestador del pago (lección de tácticas de interoperabilidad)
Gestionar recursos	Controlar el acceso a recursos compartidos	Límites de tasa por consumidor de la API

Tip
La mitad de la tabla ya apareció en Modificabilidad con otro nombre —encapsular, intermediario, abstraer servicios comunes, descubrir—, y no es casualidad: integrabilidad y modificabilidad son atributos hermanos. La diferencia está en de quién es el cambio. En modificabilidad el cambio es nuestro y queremos que no se propague; en integración el cambio viene del otro lado —de un componente que no controlamos— y queremos que no nos alcance.

Los patrones que cierran la distancia

Idea clave
Los tres atacan la distancia desde ángulos distintos. El Wrapper (adaptador) traduce una interfaz “rara” a una limpia —cierra la distancia sintáctica y de datos sin tocar el componente original—. El Bridge separa la abstracción de la implementación para que evolucionen por separado —integración pensada para el cambio futuro—. El Mediator cambia la topología: en vez de N componentes hablándose todos con todos (N×N contratos que mantener), cada uno habla solo con el mediador (N) —cierra la distancia de comportamiento y centraliza la orquestación—.

Escenarios de integración e interoperabilidad

Idea clave
Igual que en modificabilidad, la medida más arquitectónica es la de estructura: cuántos componentes e interfaces existentes hay que tocar. “Cero interfaces existentes modificadas” es una promesa de diseño, porque solo se cumple si existe el puerto IPasarela con un adaptador por banco. La medida delata la táctica.

Estilos y patrones de integración empresarial

Idea clave
Ninguno es “el correcto”. El estilo se elige por interacción, no por sistema: en el mismo Pagora conviven la llamada remota (autorizar con el banco mientras el usuario espera), la mensajería (avisar a los interesados en un pago), el archivo (la conciliación nocturna) y, a veces, la base compartida impuesta por un legado. Lo que el arquitecto decide es qué acoplamiento acepta en cada interacción y por qué.

Tip
La diferencia es de acoplamiento. Con comandos, Pagos sigue conociendo a cada destinatario, solo que le habla por un canal en vez de llamarlo. Con eventos, Pagos no conoce a nadie: un interesado nuevo se suscribe sin que Pagos cambie. Un buen síntoma de diseño es el nombre: los eventos se nombran en pasado (PagoConfirmado) y los comandos en imperativo (AutorizarPago). Un “evento” llamado EnviarCorreoAlUsuario es un comando disfrazado, y acopla al emisor con un destinatario concreto.

Los patrones de mensajería que más se usan

Patrón	Qué resuelve	En Pagora
Canal punto a punto	Un mensaje lo procesa exactamente un consumidor	Las órdenes de pago pendientes de enviar al banco
Publicar-suscribir	Un mensaje llega a todos los suscritos	PagoConfirmado a Notificaciones, Fidelización y Contabilidad
Enrutador por contenido	Decidir el destino según lo que trae el mensaje	Los pagos internacionales van a una cola distinta
Traductor de mensajes	Convertir entre el formato de un sistema y el de otro	Del formato interno de Pagora al del Banco A
Modelo de datos canónico	Un formato común para no traducir entre cada par	El tema de la próxima lección
Agregador	Juntar varios mensajes relacionados en uno	Las respuestas de tres verificaciones antes de aprobar
Receptor idempotente	Procesar sin daño un mensaje que llega dos veces	El mismo reverso enviado dos veces por el banco
Canal de mensajes muertos	Apartar lo que no se pudo procesar, sin perderlo	Un mensaje con un formato que nadie entiende

Advertencia
Tubos tontos, extremos inteligentes. Una tentación frecuente es poner la lógica de negocio dentro del bus de integración: enrutamientos con reglas comerciales, transformaciones que deciden, orquestaciones enteras en la herramienta de integración. El resultado es un componente central del que todo depende y que nadie del negocio entiende. La recomendación que se impuso con los microservicios es la contraria: el canal solo transporta, y las decisiones viven en los servicios (Lewis y Fowler, 2014). Es la misma advertencia de la lección anterior sobre el mediador que crece hasta saberlo todo.

Niveles de interoperabilidad y estándares


De conectarse a entenderse
El modelo de niveles de interoperabilidad conceptual (LCIM) ordena esos acuerdos de menor a mayor (Tolk y Muguira, 2003):

Nivel	Qué comparten los sistemas	Qué se rompe si falta	En Pagora y el Banco A
Técnico	Un protocolo y una red	No hay conexión	HTTPS sobre una VPN acordada
Sintáctico	Un formato de los datos	Los mensajes no se pueden leer	Mensajes XML que validan contra un esquema
Semántico	El significado de los datos	Se leen, pero se interpretan mal	Montos en la unidad de la moneda, moneda en ISO 4217
Pragmático	Para qué se usa cada mensaje en el proceso del otro	Se entienden, pero se usan mal	Que un reverso anula la orden y no es un pago nuevo
Dinámico	Cómo cambian los estados a lo largo del intercambio	Los dos sistemas terminan en estados que no coinciden	Qué pasa con la reserva si el banco no responde
Conceptual	Un modelo común del dominio	Cada cambio exige renegociar todo	Los dos entienden igual qué es un pago, una cuenta y una devolución
Idea clave
Las cinco distancias de la primera lección del capítulo son la otra cara de esta escala. La distancia sintáctica se cierra en el nivel sintáctico; la semántica en datos, en el semántico; la semántica en comportamiento y la temporal, en el pragmático y el dinámico. Los niveles bajos los resuelve la tecnología; los altos solo se resuelven con acuerdos entre personas, y por eso son los que más tardan y más cuestan.



Tip
Al estimar una integración con un aliado, las capas legal y organizacional suelen ser el camino crítico. La API se integra en semanas; el contrato de intercambio de datos, el acuerdo de niveles de servicio y el procedimiento de conciliación pueden tardar meses. Un arquitecto que solo planea la capa técnica entrega un sistema conectado que no puede operar.

Idea clave
Por eso, cuando existe, lo mejor es usar como canónico un estándar que otro mantiene. Un banco que adopta ISO 20022 como su modelo interno de pagos obtiene los beneficios del canónico sin cargar solo con su gobierno, y de paso habla el idioma de sus contrapartes. Cuando no existe, un canónico propio y pequeño —solo los conceptos que cruzan fronteras— suele funcionar mejor que uno que intenta modelarlo todo.

Evolución de contratos sin romper a los consumidores


Advertencia
Mantener versiones tiene un costo que crece con cada una: código duplicado, pruebas duplicadas, correcciones que hay que aplicar en todas. Un proveedor que nunca retira versiones termina con la generalidad especulativa del capítulo anterior a escala de API. La deprecación con plazo no es una cortesía con los consumidores: es lo que permite al proveedor seguir siendo modificable.

Tácticas de interoperabilidad

Tip
El descubrimiento es la misma idea que vimos en modificabilidad (la táctica descubrimiento para diferir el binding): localizar la dependencia en ejecución en vez de fijarla en el código. En interoperabilidad se vuelve central —los sistemas aparecen y desaparecen— y por eso el registro de servicios es una pieza de infraestructura, no un detalle. En Pagora, descubrir la pasarela vigente por un registro permite cambiar de proveedor sin re-desplegar.

Orquestación vs. coreografía

Orquestación — un componente central dirige: llama a los demás en orden y coordina todo. Control y visibilidad (el flujo vive en un lugar), a cambio de un centro del que todos dependen.
Coreografía — no hay director: los participantes intercambian eventos de forma autónoma y cada uno reacciona a lo suyo. Bajo acoplamiento y resiliencia, a cambio de que el flujo global no viva en ningún lado (más difícil de seguir).

Idea clave
No es “una u otra” para todo el sistema: se elige por flujo. El camino crítico del dinero —donde el orden y el control importan— suele orquestarse (un orquestador de pago llama a Cuentas, Pagos, Envíos en orden). Lo secundario y desacoplado —notificaciones, analítica— suele coreografiarse (Pagos publica “pago confirmado” y quien quiera reacciona). Es el mismo criterio de siempre: control donde el riesgo es alto, desacoplamiento donde se puede.

Idea clave
Aquí la orquestación y la coreografía dejan de ser una preferencia de estilo y se vuelven una decisión sobre quién sabe deshacer qué. En una saga orquestada, el orquestador conoce el flujo completo y ordena las compensaciones: es más fácil de seguir y de cambiar. En una saga coreografiada, cada servicio escucha los eventos de falla y compensa lo suyo: nadie es un punto central, pero el flujo de compensación no está escrito en ningún lugar. Para el camino crítico del dinero, la orquestación suele ganar por lo mismo de siempre: control donde el riesgo es alto.

Advertencia
Una saga cambia lo que el usuario ve. Sin transacción global, hay un momento en que el pago está en proceso: el saldo está reservado pero no debitado. Eso no es un defecto que esconder sino un estado que hay que diseñar —mostrarlo en la app, impedir que la reserva se use dos veces, definir cuánto puede durar—. Es la consistencia eventual, vista desde la experiencia del cliente.