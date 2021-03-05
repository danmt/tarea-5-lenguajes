# Tarea 5 de Lenguajes

## Ejercicio 0

a) Dado que "Secuencial" recibe dos parametros no puede ser una instancia de Monad. Basandonos en 
que "a" puede ser de cualquier tipo, tenemos un Monad Secuencial para cada tipo. 

b)
  - return :: a              -> Secuencial s a
  - (>>=)  :: Secuencial s a -> (a -> Secuencial s b) -> Secuencial s b
  - (>>)   :: Secuencial s a -> Secuencial s b        -> Secuencial s b
  - fail   :: String         -> Secuencial s a

c)
instance Monad (Secuencial s) where 
  return x = Secuencial $ \s -> (a,s)
  
d)
instance Monad (Secuencial s) where
  (Secuencial programa) >>= transformador = 
    Secuencial $ \estadoInicial -> 
      let (resultado,nuevoEstado)    = programa      estadoInicial 
          (Secuencial nuevoPrograma) = transformador resultado
      in nuevoPrograma nuevoEstado 

## Ejercicio 1

a) 
subs (id const) const id -- Aplicamos subs con argumentos "(id const)", "const" y "id", sin las comillas dobles
(id const) id (const id) -- Aplicamos id con argumento "const", sin las comillas dobles
const id (const id) -- Aplicamos const con argumentos "id" y "(const id)", sin las comillas dobles
id

El resultado de aplicar las funciones es la funcion id, comprobamos por ghci ejecutando:

  subs (id const) const id 5

El resultado es 5, tal como se esperaba.

b) La expresion que devuelve la misma expresion es:

  subs const id subs
  
Al evaluar subs con estos argumentos, se tiene como resultado la misma funcion subs. Puede aplicarse infinitamente, por ejemplo, si se ejecuta por ghci:

  subs const id 3

Y vemos que la ejecucion resultante es:

  subs const id subs const id subs const id subs const id subs const id subs const id subs const id subs const id 3
  
El resultado al final sera 3 en ambos casos, pero la segunda instruccion tarda mas en ejecutarse. Con esto en cuenta,
podemos definir la siguiente expresion por ghci:

  nuncaTermina var = do var const id subs; nuncaTermina var
  
Luego, al ejecutar por ghci:

  nuncaTermina subs const id 1
  
ghci empieza ejecutando la funcion nuncaTermina con argumento subs, pero nunca sale del ciclo porque la variable var de la funcion nuncaTermina siempre sera la funcion subs. Notese que no podemos ejecutar por ghci simplemente:

  nuncaTersmina subs

Ya que no tenemos un Show definido para la expresion resultante, por eso le pasamos 3 argumentos adicionales
que son: const id 1

c) id' = subs const const

d) 
El cálculo de combinadores SKI son funcionalmente equivalentes a las funciones propuestas, en este caso,
I corresponde a la función id, (funcion identidad, toma un argumento y devuelven e mismo argumento), 
K corresponde a la función const (funcion constante, toma dos argumentos y devuelve el primer argumento) y 
S corresponde a la función subs (funcion de aplicación/sustitución, toma 3 argumentos, aplica el 1er al 3er argumento 
y al resultado de aplicar el 2do argumento al 3er argumento)
