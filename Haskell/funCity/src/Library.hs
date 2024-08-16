module Library where
import PdePreludat

data Ciudad = Ciudad {
nombre :: String,
aniofundacion :: Number,
atracciones :: [String],
costoDeVida :: Number
} deriving (Show, Eq)

isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

-- Punto 1

valorDeCiudad :: Ciudad -> Number
valorDeCiudad ciudad
    | ((<1800).aniofundacion) ciudad     =       ((*5).(1800-).aniofundacion) ciudad
    | (null . atracciones) ciudad  =       ((*2).costoDeVida) ciudad
    | otherwise                        =       ((*3).costoDeVida) ciudad

-- Punto 2
-- Integrante 1
atraccionCopada :: Ciudad -> Bool
atraccionCopada = (any (isVowel . head) . atracciones)



-- Integrante 2
ciudadSobria :: Number -> Ciudad -> Bool
ciudadSobria cantLetras ciudad
    | (null.atracciones) ciudad = False
    |otherwise = (all ((>cantLetras) . length) . atracciones) ciudad

ciudadSobria' :: Number -> Ciudad -> Bool
ciudadSobria' cantLetras ciudad = (not . null . atracciones) ciudad && (all ((>cantLetras) . length) . atracciones) ciudad

-- Integrante 3

ciudadNombreRaro :: Ciudad -> Bool
ciudadNombreRaro = ((<5) . length . nombre)

-- Punto 3

sumaAlCostoDeVidad :: Ciudad -> Number -> Number
sumaAlCostoDeVidad ciudad costo  = costoDeVida ciudad + ((costo/100) * costoDeVida ciudad)

sumaAlCostoDeVidad' :: Number -> Evento
sumaAlCostoDeVidad' costo ciudad = ciudad {
    costoDeVida = costoDeVida ciudad + ((costo/100) * costoDeVida ciudad)
}


type Evento = Ciudad->Ciudad


--Grupal

sumarNuevaAtraccion  :: String -> Evento
sumarNuevaAtraccion nuevaAtraccion ciudad = sumaAlCostoDeVidad' 20 ciudad {
    atracciones = nuevaAtraccion:atracciones ciudad
}

--Integrante 1
crisis :: Evento
crisis ciudad = ciudad{
    atracciones= (quitarUltimoElemento . atracciones) ciudad,
    costoDeVida = sumaAlCostoDeVidad ciudad (-10)
}

quitarUltimoElemento :: [a] -> [a]
quitarUltimoElemento [] = []
quitarUltimoElemento lista = init lista

--Integrante 2
remodelacionCiudad:: Number -> Evento
remodelacionCiudad costoRemodelacion ciudad  = ciudad{
    nombre= "New " ++ nombre ciudad,
    costoDeVida = sumaAlCostoDeVidad ciudad costoRemodelacion
}


--Integrante 3

reevaluacionCiudad :: Number -> Evento
reevaluacionCiudad cantidadLetras ciudad
    | ciudadSobria cantidadLetras ciudad = ciudad{costoDeVida = sumaAlCostoDeVidad ciudad 10}
    | otherwise                          = ciudad{costoDeVida = costoDeVida ciudad - 3}



-- Punto 4

-- Para crear una ciudad que se pueda usar en la consola se debe hacer
-- let nuevaCiudad = Ciudad "Azul" 1832 ["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"] 190


-- el agregado de una nueva atracción
-- sumarNuevaAtraccion "Buenos Aires" nuevaCiudad

-- una remodelación
-- remodelacionCiudad 50 nuevaCiudad

-- una crisis
-- crisis nuevaCiudad

-- una reevaluacion 
-- reevaluacionCiudad 30 nuevaCiudad 

-- para que se realice todo junto es necesario hacer uso de composicion ya que no se puede afectar una variable en ghci, incluso aplicando sumarNuevaAtraccion a 
-- nuevaCiudad no se altera nuevaCiudad, sino que se crea una ciudad diferente que tiene como valor el contenido de nuevaCiudad luego de que se aplique sumarNuevaAtraccion

--(reevaluacionCiudad 10.crisis.remodelacionCiudad 50.sumarNuevaAtraccion "buenos aires") ciudad



-- Segunda entrega

  -- Punto 1

    -- 1

type Anio = (Number,[Evento])

eventos :: Anio -> [Evento]
eventos = snd

aniosPasan ::Ciudad->Anio->Ciudad
aniosPasan ciudad   = foldr  ($) ciudad . eventos

    -- 2

type Criterio = Ciudad -> Number

compararCostoVida :: Criterio
compararCostoVida   = costoDeVida

compararAtracciones :: Criterio
compararAtracciones = (length.atracciones)

algoMejor :: Ciudad->Criterio->Evento->Bool
algoMejor ciudad criterio evento = criterio ciudad < criterio (evento ciudad)


aplicarEventosFiltradosPorCriterio :: Criterio -> Ciudad -> Anio -> Ciudad
aplicarEventosFiltradosPorCriterio criterio ciudad = foldr ($) ciudad . filtrarEventosDeUnAnioSegunCriterio ciudad criterio

filtrarEventosDeUnAnioSegunCriterio :: Ciudad -> Criterio -> Anio -> [Evento]
filtrarEventosDeUnAnioSegunCriterio ciudad criterio  = filter (algoMejor ciudad criterio). eventos
-- Integrante 1
-- 1.3
costoDeVidaSube :: Ciudad -> Anio -> Ciudad
costoDeVidaSube = aplicarEventosFiltradosPorCriterio costoDeVida --(foldr ($) ciudad . filter (algoMejor ciudad costoDeVida)) (snd anio)

--Integrante 2 Punto 1.4
bajenElCostoDeVida :: Ciudad -> Anio -> Ciudad
bajenElCostoDeVida = aplicarEventosFiltradosPorCriterio (negate.costoDeVida)--(foldr ($) ciudad . filter(not.algoMejor ciudad compararCostoVida)) (snd anio)

--Integrante 3 
-- 1.5

valorQueSuba :: Ciudad -> Anio -> Ciudad
valorQueSuba = aplicarEventosFiltradosPorCriterio valorDeCiudad --(foldr ($) ciudad . filter(valorMayor ciudad)) (snd anio)

-- valorMayor :: Ciudad -> Evento -> Bool
-- valorMayor ciudad evento = valorDeCiudad ciudad < valorDeCiudad (evento ciudad)


-- Punto 2 Funciones a la orden

-- 2.1 integrante 1
eventosOrdenados:: Anio -> Ciudad -> Bool
eventosOrdenados (_,[_]) _ = True
eventosOrdenados (fundacion,evento1:evento2:eventos) ciudad = mejorDeDos costoDeVida ciudad evento1 evento2 && eventosOrdenados (fundacion,evento2:eventos) ciudad

mejorDeDos :: Criterio -> Ciudad-> Evento -> Evento ->Bool
mejorDeDos criterio  ciudad evento1 evento2 =  (criterio.evento1) ciudad <= (criterio.evento2) ciudad 


-- 2.2 integrante 2
-- azul = Ciudad{nombre="Azul",aniofundacion=1832,atracciones=["Atraccion1"],costoDeVida= 190}
nullish = Ciudad{nombre="Nullish",aniofundacion=1800,atracciones=["Atraccion1"],costoDeVida=140}
caleta = Ciudad{nombre="Caleta",aniofundacion=1900,atracciones=["Atraccion1"],costoDeVida=120}
baradero = Ciudad{nombre="Baradero",aniofundacion=1832,atracciones=["Atraccion1"],costoDeVida=150}

ciudadesOrdenadas:: Evento -> [Ciudad] -> Bool
ciudadesOrdenadas _ [_] = True
ciudadesOrdenadas evento (ciudad:otraCiudad:ciudades) =
    (costoDeVida.evento) ciudad < (costoDeVida.evento) otraCiudad && ciudadesOrdenadas evento (otraCiudad:ciudades)


-- 2.3 integrante 3

aniosOrdenados :: [Anio] -> Ciudad -> Bool
aniosOrdenados [_] _ = True
aniosOrdenados (anio1:anio2:anios) ciudad = (costoDeVida.aniosPasan ciudad) anio1 < (costoDeVida.aniosPasan ciudad) anio2 && aniosOrdenados (anio2:anios) ciudad

-- Punto 3

-- Integrante 1

xs=(2024,[crisis, reevaluacionCiudad 7]++ map remodelacionCiudad [1..])


-- 2024 = (2024,[crisis, reevaluacionCiudad 7, remodelacionCiudad 1, remodelacionCiudad 2...])
-- el unico caso donde se podria obtener un resultado seria si la reevaluacionCiudad da un baja en el costo de vida, para eso la ciudad no tendria que ser sobria,
-- ya que por el lazy evaluation al encontrar un false en una cadena eterna de and, ya sabe que el resultado solo puede ser false, en caso contrario va a estar  toda la eternidad,
-- chequeando si son todos true, y al ir en aumento la remodelacion siempre lo va a ser

{- Integrante 2

  Opcion 1:
  ciudadesInfinitas :: [Ciudad]
  ciudadesInfinitas = caleta:baradero:ciudadesInfinitas

  discoRayado = [azul,nullish] ++ ciudadesInfinitas 
  
  Opcion 2:
  discoRayado = [azul,nullish] ++ cycle [caleta,baradero]
  
  Puede haber un resultado posible para la función del punto 2.2 (ciudades ordenadas) para la lista 
  “disco rayado”? Justificarlo relacionándolo con conceptos vistos en la materia.

  Si hay un resultado posible y es false, esto es posible por lazy evaluation,
  ya que si al comparar el costo de vidad de dos ciudades, da false, no seguira comparando el resto de la lista.
-}

-- Integrante 3
{-
    Si , el unico resultado posible es "False" , ya que la funcion "aniosOrdenados" ira recibiendo anios en la lista
    de anios y cuando vea que el "&&" tiene un false entonces dejara de ejecutar la recursividad y dara como resultado
    "false". 
    
    Esto solo ocurre cuando un anio de la lista hace que el costo de vida de la ciudad no sea mayor al del evento del anio anterior.

    False &&  _  =  False
    True  &&  _  =  _

-}