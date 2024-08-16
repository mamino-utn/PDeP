module Spec where
import PdePreludat
import Library
import Test.Hspec

azul = Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190}
anio2022 = (2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7])

correrTests :: IO ()
correrTests = hspec $ do
  
  --Punto 1 

  describe "Test de Valoracion de una Ciudad" $ do
    it "Valor de una ciudad muy antigua" $ do
      valorDeCiudad  Ciudad {nombre="Baradero",aniofundacion=1615, atracciones = ["Parque del Este","Museo Alejandro Barbich"],costoDeVida=150} `shouldBe` 925
    it "Valor de una ciudad sin atracciones" $ do
      valorDeCiudad Ciudad {nombre="Nullish", aniofundacion=1800,atracciones = [],costoDeVida=140} `shouldBe` 280
    it "Una ciudad con año de fundacion mayor a 1800 y que posee atracciones,tiene como valor el triple de su costo de vida" $ do
      valorDeCiudad Ciudad {nombre="Caleta Oliva", aniofundacion=1901,atracciones = ["El Gorosito","Faro Costanera"],costoDeVida=120} `shouldBe` 360
  
  --Punto 2

  --Integrante 1
  describe "Test de Atraccion copada" $ do
    it "Ciudad sin atracciones con mayusculas no es copada" $ do
      atraccionCopada Ciudad{nombre="Baradero",aniofundacion=1615, atracciones =["Parque del Este","Museo Alejandro"],costoDeVida=150} `shouldBe` False
    it "Ciudad sin atracciones no es copada" $ do
      atraccionCopada Ciudad{nombre="Nullish",aniofundacion=1800, atracciones =[],costoDeVida=140} `shouldBe` False
    it "Ciudad con atracciones con mayuscula es copada" $ do
      atraccionCopada Ciudad{nombre="Caleta Olivia",aniofundacion=1901, atracciones =["El Gorosito","Faro Costanera"],costoDeVida=120} `shouldBe` True
    


  --Integrante 2
  describe "Test de Ciudad Sobria" $ do
    it "Ciudad con atracciones con mas de 14 letras es una ciudad sobria " $ do
      ciudadSobria 14 Ciudad{nombre="Baradero",aniofundacion=1615, atracciones =["Parque del Este","Museo Alejandro"],costoDeVida=150} `shouldBe` True
    it "Ciudad con atracciones con 15 letras,tiene que dar False" $ do
      ciudadSobria 15 Ciudad{nombre="Maipu",aniofundacion=1878, atracciones =["Parque del Este","Museo Alejandro"],costoDeVida=115} `shouldBe` False
    it "Ciudad sin atracciones es sobria con 5 letras,tiene que dar False" $ do
      ciudadSobria 5 Ciudad{nombre="Nullish",aniofundacion=1800, atracciones =[],costoDeVida=140} `shouldBe` False

  --Integrante 3
  describe "Test de nombre raro" $ do
    it "Ciudad con nombre con menos de 5 letras" $ do
      ciudadNombreRaro Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Espanol","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} `shouldBe` True
    it "Ciudad con nombre con 5 letras o mas" $ do
      ciudadNombreRaro Ciudad{nombre="Maipu",aniofundacion=1878, atracciones =["Fortin Kakel"],costoDeVida=115} `shouldBe` False

  --Punto 3

  --Grupal

  describe "Test Nueva Atraccion" $ do
    it "Ciudad con 2 atracciones deberia pasar a tener 3 atracciones y un aumento del %20 en el costo de vida" $ do
      sumarNuevaAtraccion "Nueva atraccion" Ciudad{nombre="Azul",aniofundacion=1832,atracciones=["Parque del Este","Estatua del Fundador"],costoDeVida=190} `shouldBe` Ciudad{nombre="Azul",aniofundacion=1832,atracciones=["Nueva atraccion","Parque del Este","Estatua del Fundador"],costoDeVida=228}
  
  --Integrante 1
  describe "Test de Crisis" $ do
    it "Una ciudad con una crisis, pierde la ultima atraccion y dismiuye su costo de vida 10%" $ do
      crisis Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} `shouldBe` Ciudad{nombre="Azul",aniofundacion=1832,atracciones=["Teatro Español","Parque Municipal Sarmiento"],costoDeVida=171}
    it "Una ciudad con una crisis y sin atracciones dismiuye su costo de vida 10%" $ do
      crisis Ciudad{nombre="Nullish",aniofundacion=1800, atracciones =[],costoDeVida=140} `shouldBe` Ciudad{nombre="Nullish",aniofundacion=1800,atracciones=[],costoDeVida=126}
      
  

  --Integrante 2
  describe "Test de Remodelacion" $ do
    it "Una ciudad con una remodelacion del %50,Tiene New en su nombre y aumenta su costo de vida un %50" $ do
      remodelacionCiudad 50 Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Casa Del Terror","Teatro Colon"],costoDeVida=190} `shouldBe` Ciudad{nombre="New Azul",aniofundacion=1832,atracciones=["Casa Del Terror","Teatro Colon"],costoDeVida=285}
  
  --Integrante 3

  describe "Test de Reevaluación " $ do
    it "Una ciudad que no es sobria con no mas de n letras" $ do
      reevaluacionCiudad 14 Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} `shouldBe` Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=187}
    it "Una ciudad sobria con mas de n letras" $ do
      reevaluacionCiudad 13 Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} `shouldBe` Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=209}
   
  -- Entrega 2

  -- Grupal
  describe "Test de Años Pasan" $ do
    it "Una ciudad que en un año tuvo una crisis, una remodelacion y una reevaluacion" $ do
      (nombre .aniosPasan azul) anio2022  `shouldBe` "New Azul"
      (atracciones.aniosPasan azul) anio2022 `shouldNotContain` ["Costanera Cacique Catriel"]

    it "Una ciudad que en un año no tuvo eventos" $ do
      aniosPasan Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} (2015,[])`shouldBe` Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190}

  describe "Test de Algo Mejor" $ do
    it "Una ciudad que tuvo una crisis y compara el costo de vida" $ do
      algoMejor Ciudad{nombre="Azul",aniofundacion=1832, atracciones=["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} compararCostoVida crisis `shouldBe` False
    it "Una ciudad suma una nueva atraccion y compara el costo de vida" $ do
      algoMejor Ciudad{nombre="Azul",aniofundacion=1832, atracciones=["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} compararCostoVida (sumarNuevaAtraccion "Monasterio Trapense") `shouldBe` True
    it "Se agrega una nueva atraccion a una ciudad y compara la cantidad de atracciones" $ do
      algoMejor Ciudad{nombre="Azul",aniofundacion=1832,atracciones=["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} compararAtracciones (sumarNuevaAtraccion "Monasterio Trapense") `shouldBe` True
  
  -- Punto 1

  -- Integrante 1
  describe "Test de Costo de Vida que sube" $ do
    it "Una ciudad que en un año tuvo eventos, solo se queda con los que suben el costo de  vida" $ do
      costoDeVidaSube Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} (2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7]) `shouldBe` Ciudad{nombre="New Azul",aniofundacion=1832,atracciones=["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=219.45}
  --Integrante 2
  describe "Test de Costo de Vida que Baje" $ do
    it "Una ciudad que en un año paso una crisis,una remodelacion y una reevaluacion.Baja su costo de vida,no cambia el nombre y pierde una atraccion" $ do
      bajenElCostoDeVida Ciudad{nombre="Azul",aniofundacion=1832, atracciones =["Teatro Español","Parque Municipal Sarmiento","Costanera Cacique Catriel"],costoDeVida=190} (2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7]) `shouldBe` Ciudad{nombre="Azul",aniofundacion=1832,atracciones=["Teatro Español","Parque Municipal Sarmiento"],costoDeVida=171}
  
  --Integrante 3
  describe "Test de aplicar eventos si el valor sube" $ do
    it "Una ciudad que se le aplican eventos solo si cada evento hace que el valor de la ciudad suba" $ do
      valorQueSuba Ciudad{nombre="Nullish",aniofundacion=1800, atracciones =[],costoDeVida=140} (2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7]) `shouldBe` Ciudad{nombre="New Nullish",aniofundacion=1800,atracciones=[],costoDeVida=147} 
  
  -- Punto 2

  -- Integrante 1
  describe "Test de eventos ordenados" $ do
    it "El anio esta ordenado entonces el costo de vida sube con cada evento" $ do
     azul `shouldSatisfy` eventosOrdenados (2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7])
    it "El anio esta desordenado entonces el costo de vida no sube con cada evento" $ do
      eventosOrdenados (2023,[crisis,sumarNuevaAtraccion "parque",remodelacionCiudad 10,remodelacionCiudad 20]) azul `shouldBe` False  
  -- Integrante 2
  describe "Test de Ciudades Ordenadas" $ do
    it "A una lista de ciudades se les aplica un evento, las ciudades esta en orden creciente respecto al costo de vida" $ do
      ciudadesOrdenadas (remodelacionCiudad 10) [caleta,nullish,baradero,azul] `shouldBe` True 
    it "A una lista de ciudades se les aplica un evento, las ciudades no esta ordenadas" $ do
      ciudadesOrdenadas (remodelacionCiudad 10) [caleta,azul,baradero] `shouldBe` False 
  
  --Integrante 3
  describe "Test de Anios ordenados" $ do
    it "Ciudad a la que se le aplican los eventos de una lista de años ordenados segun costo de vida de la ciudad en orden ascendente" $ do
      aniosOrdenados [ (2021,[crisis,sumarNuevaAtraccion "playa"]),(2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7]),(2023,[crisis,sumarNuevaAtraccion "parque",remodelacionCiudad 10,remodelacionCiudad 20]) ] baradero `shouldBe` False  
    it "Ciudad a la que se le aplican los eventos de una lista de años desordenados segun costo de vida" $ do
      aniosOrdenados [ (2022,[crisis,remodelacionCiudad 5,reevaluacionCiudad 7]),(2021,[crisis,sumarNuevaAtraccion "playa"]),(2023,[crisis,sumarNuevaAtraccion "parque",remodelacionCiudad 10,remodelacionCiudad 20]) ] baradero `shouldBe` True  