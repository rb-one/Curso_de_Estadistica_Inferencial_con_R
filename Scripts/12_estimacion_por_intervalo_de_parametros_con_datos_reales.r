
# Correr nuestro código de intervalo de confianza con datos reales --------


# Paquetes ----------------------------------------------------------------

# install.packages("devtools")
# devtools::install_github("nebulae-co/saber")

library("saber")

data("SB11_20112")

# intervalos de confianza de la media -------------------------------------

table(SB11_20112$ECON_SN_INTERNET)

tamano_muestral <- 3000
iteraciones <- 100


pobla_A <- SB11_20112$FISICA_PUNT[SB11_20112$ECON_SN_INTERNET == 0]
pobla_B <- SB11_20112$FISICA_PUNT[SB11_20112$ECON_SN_INTERNET == 1]
media_pob_A <- mean(pobla_A, na.rm = TRUE)
media_pob_B <- mean(pobla_B, na.rm = TRUE)

# Centramos de forma inicial el plot en el area de la media poblacional
plot(media_pob_A, media_pob_B, col = 4, pch = 20)
# Trazamos la recta  Y = X
abline(0,1)
# Esta recta se cruza con el rectangulo solo si los intervalos de confianza 
# comparten una region 



for(i in seq_len(iteraciones)){
  #sec_len es toda la secuencia de numeros del 0 al valor del la var iteraciones
  
  # obtenemos la muestra
  muestra <- sample(seq_len(nrow(SB11_20112)), tamano_muestral)
  
  # Tomo todas las filas del DataFrame tomo aquella "in" la muestra y sin internet
  cuales_A <- seq_len(nrow(SB11_20112)) %in% muestra & SB11_20112$ECON_SN_INTERNET == 0
  # Obtengo la muestra_A un subset usando la mascar logica cuales_A
  muestra_A <- SB11_20112$FISICA_PUNT[cuales_A]
  
  # Tomo todas las filas del DataFrame tomo aquella "in" la muestra y con internet
  cuales_B <- seq_len(nrow(SB11_20112)) %in% muestra & SB11_20112$ECON_SN_INTERNET == 1
  # Obtengo la muestra_B un subset usando la mascar logica cuales_B
  muestra_B <- SB11_20112$FISICA_PUNT[cuales_B]
  

  # Obtenemos media muestral de A
  media_muestra_A <- mean(muestra_A, na.rm = TRUE)
  
  # Realizamos test t de student en la muestra_A
  t_test_A <- t.test(muestra_A)
  
  # obtenemos un intervalo de la muestra A a partir del test t objeto conf.int
  intervalo_A <- t_test_A$conf.int

  # obtengo los intervalos maximos y minimos para A
  LI_A <- min(intervalo_A)
  LS_A <- max(intervalo_A)
  
  
  # Obtenemos media muestral de B
  media_muestra_B <- mean(muestra_B, na.rm = TRUE)
  
  # Realizamos test t de student en la muestra_B
  t_test_B <- t.test(muestra_B, na.rm = TRUE)
  
  # obtenemos un intervalo de la muestra B a partir del test t objeto conf.int
  intervalo_B <- t_test_B$conf.int
  
  # obtengo los intervalos maximos y minimos para B
  LI_B <- min(intervalo_B)
  LS_B <- max(intervalo_B)
  
  # points(media_muestra_A, media_muestra_B, col = 2, pch = 20)
  rect(LI_A, LI_B, LS_A, LS_B)
  
}

# Graficamos los datos
points(media_pob_A, media_pob_B, col = 4, pch = 20, cex = 2)































