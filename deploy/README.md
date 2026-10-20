# deploy/

La topología del prototipo: cómo se levanta todo junto, y la observabilidad.

Suele contener el archivo de composición, la configuración del almacenamiento y
de la mensajería si aplica, y los tableros de métricas.

No abra el tablero de observabilidad mientras una ejecución mide, si su carga
puede competir con lo que se está midiendo. En el reto 2 la carga del tablero
llegó a vencer sondeos del componente que se estaba midiendo.
