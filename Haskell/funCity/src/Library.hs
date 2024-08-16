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

sumaAlCostoDeVidad' :: Number -> Ciudad -> Ciudad
sumaAlCostoDeVidad' costo ciudad = ciudad {
    costoDeVida = costoDeVida ciudad + ((costo/100) * costoDeVida ciudad)
}

--Grupal

sumarNuevaAtraccion  :: String -> Ciudad -> Ciudad
sumarNuevaAtraccion nuevaAtraccion ciudad = sumaAlCostoDeVidad' 20 ciudad {
    atracciones = nuevaAtraccion:atracciones ciudad
}

--Integrante 1
crisis :: Ciudad -> Ciudad
crisis ciudad = ciudad{
    atracciones= (quitarUltimoElemento . atracciones) ciudad,
    costoDeVida = sumaAlCostoDeVidad ciudad (-10)
}

quitarUltimoElemento :: [a] -> [a]
quitarUltimoElemento [] = []
quitarUltimoElemento lista = init lista

--Integrante 2
remodelacionCiudad:: Number -> Ciudad -> Ciudad
remodelacionCiudad costoRemodelacion ciudad  = ciudad{
    nombre= "New " ++ nombre ciudad,
    costoDeVida = sumaAlCostoDeVidad ciudad costoRemodelacion
}


--Integrante 3

reevaluacionCiudad :: Number -> Ciudad -> Ciudad
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

---- Parte 2

type Evento = Ciudad -> Ciudad

data Anio = Anio {
   anio :: Number,
   eventos :: [Evento]
} deriving (Show, Eq)

pasoDeAnio :: Ciudad -> Anio -> Ciudad
pasoDeAnio ciudad anio = foldr ($) ciudad (eventos anio)

type CriterioComparacion = Ciudad -> Ciudad -> Bool

comparacionCostoVida :: CriterioComparacion
comparacionCostoVida  ciudad ciudadConEvento = costoDeVida ciudad < costoDeVida ciudadConEvento

comparacionAtracciones :: CriterioComparacion
comparacionAtracciones ciudad ciudadConEvento = (length.atracciones) ciudad < (length.atracciones) ciudadConEvento

algoMejor :: Ciudad -> CriterioComparacion-> Evento -> Bool
algoMejor ciudad criterioComparacion evento = criterioComparacion ciudad (evento ciudad)