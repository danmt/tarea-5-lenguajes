{- 

0.a) Dado que "Secuencial" recibe dos parametros no puede ser una instancia de Monad. Basandonos en 
que "a" puede ser de cualquier tipo, estamos en presencia de varios Monads "Secuencial". Al proveer
"s", debe

0.b)
  - return :: a              -> Secuencial s a
  - (>>=)  :: Secuencial s a -> (a -> Secuencial s b) -> Secuencial s b
  - (>>)   :: Secuencial s a -> Secuencial s b        -> Secuencial s b
  - fail   :: String         -> Secuencial s a

0.c)
instance Monad (Secuencial s) where 
  return x = Secuencial $ \s -> (a,s)

0.d)
instance Monad (Secuencial s) where
  (Secuencial programa) >>= transformador = 
    Secuencial $ \estadoInicial -> 
      let (resultado,nuevoEstado)    = programa      estadoInicial 
          (Secuencial nuevoPrograma) = transformador resultado
      in nuevoPrograma nuevoEstado 

 -}