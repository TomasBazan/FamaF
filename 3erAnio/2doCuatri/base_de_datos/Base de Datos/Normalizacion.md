Descomposicion de un esquema: 
{R_1, ..., R_m} es una descomposicion del esquema R <=> R = R1 U ... U Rm

SimaBib = (nombre, DNI, posicion, )

{A_1, ..., A_j} son elementos de redundancia de la informacion para un mismo concepto

R: Esquema Universal

SistemaBib = ( nombre, DNI, posicion, numInv, nombreBib, calle, numero, ISBN, titulo, autor)
$A_1,  ... , A_j$ atributos de redundancia de informacion asociado a un concepto

ISBN -> titulo
SimaBib'' = Sima Bib' - {titulo}
(ISBN, titulo)


${A_1, ... ,A_j} \subseteq$ concepto

$\alpha$ -> $\beta$

Las dependencias interesantes son las que no determinan todo el conjunto de la imagen

$\alpha   -> \beta$  cuando no vale $\alpha -> R$ tenemos un $\beta$ es un conjunto de elementos redundantes

$\alpha -> \beta$ se cumple para $R$ (Esquema universal) <=> $\forall$ r(R) legal y $t_1, t_2 \in n, t_1 \neq t_2$ 
$\alpha(t_1) = \alpha(t_2) => \beta$

Ejemplo

| A | B | C |
|---|---|---|
|$a_1$| $b_1$ | $c_1$| 
|$a_2$| $a_1$ | $c_1$ |
|$a_1$|$b_2$|$c_2$


$A->B$
$\neg A->C$
$B->A$



Ej: 
Como encontrar las dF de un problema del mundo real?
DNI -> Nombre, posicion
DNI -> nombre, DNI -> posicion

$R = (A,B,C,G,H,I),  F={A -> B, A ->C, B->H}$
A -> B, C    A -> H                         // Estas no son necesarias ya que son deducibles de las de arriba

#### Axiomas de Armstrong

Reflexibidad:
Si $\beta \subseteq \alpha => \alpha -> \beta$ 
Transitividad:
Si $\alpha -> \beta ^ \beta -> \gamma => \alpha -> \gamma$
Aumentatividad:
Si $\alpha -> \beta$ vale ^ $\gamma \subseteq R => \alpha \gamma -> \beta \gamma$


deducir $A C ->D$ de $A->B ^ CB -> D$
1) $A$ -> $B$
2) $CB$ -> $D$
3) $CA$ -> $CB$   aumentatividad en 1
4) $CA$ -> $D$  transitividad entre 2 y 3

F $\vdash \alpha$ -> $\beta$ 
F se deduce de $\alpha$ -> $\beta$ 

Se pueden inferir a partir de los axiomas de Armstrong.

+ **Unión:** if $\alpha → \beta$  and $\alpha → \gamma$ , then $\alpha → \beta \gamma$
+ **Descomposición:** if $\alpha → \beta \gamma$, then $\alpha → \beta$ and $\alpha → \gamma$
+ **Pseudotransitividad:** if $\alpha → \beta$ and $\gamma \beta → \delta$, then $\alpha \gamma → \delta$


