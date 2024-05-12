Sistemas de retorno de informacion

## Lenguages de consulta
#### Tipos
* Basada en terminos booleanos
* Texto en lenguaje natural, como pregunta o texto descriptivo
* Basados en expresiones regulares
* Basados en proximidad

### Resultados de una consulta
lista de indentificadores que viene con un texto 
Una URL con algo de texto

Resultado de busqueda de documentos 
- retornados ordenados por relevancia o popularidad

Si una palabra aparece en muchos documentos esta no es relevante a la consulta

### Consulta
Los terminos que no sean los que aparecen siempre

O veo los terminos o los m_gramas
## Modelos estadisticos

## Modelo booleano
Solo interesa que el documento satisfaga la expresion booleana
mapeo de palabras a enteros

- armo vocabulario: palabras mapeadas a enteros
- armo el resumen de cada documento: es un vector booleano
Mapea las ocurrencias
### Modelo de espacio vectorial
- Sigo teniendo vocabulario mapeado a enteros
- Seguimos teniendo un vector indexado por enteros, donde cada entero representa una palabra
- El contenido de una coordenada debe ayudar a determinar la relevancia de un termino
	- Por ejemplo la frecuencia(cuantas veces aparece una palabra)
	- Por ejemplo el peso del termino TF-IDF
	- Por ejemplo posiciones en el documento del termino
Esto ayuda a calcular la relevancia 


TF-IDF

TF: frecuencia de termino

IDF: inverse document frequency

m TF - IDF = mTF * mIDF

TF_i, _j = (f_{i,j})  /   ($\sum_{i=1}^{|v|} f_{i,j}$)
$IDF_{i}$ = log ($M/M_{i}$)
$n_{i}$ = cant docs que tienen termino i


Sea lenguaje de consultas $t_i,...,t_m$

definir relevancia de documentos con respecto a consulta q usando TF-IDF

$R_{j,q}=\sum_{i\leq i \leq m}TFIDF_{t_i,j}$


Similitud de vectores

cos(angulo entre vectores)
	de la consulta y documento
cos($V_q, V_j$)= $V_q, v_j$  / $||V_q|_2 . |V_j||$    =      $\sum_{i=1}^{|v|} V_{iq} * V_{i,q=j}$   /   $\sqrt{\sum_{i=1}^{N} V_{i,q}^2} * \sqrt{\sum_{i=1}^{N} V_{i,j}^2}$ 

Como determinar el vocabulario
- remover palabras vacias (stop word removal)
	* aparecen en 80% o mas de los documentos
	* usar listas de palabras pre-establecidas
Hay palabras q significan lo mismo como por ej: computer, computing, etc -> considero solo comput
q pija es tesauro? lo mismo que sinonimo
- Manejar tesauro, todos los sinonimos tengan un mismo indice (palabra representante)
### Indice Invertido


Para palabras: indice de arbol B+
Para la lista de documentos guardarla en bloques contiguos
