
# En el espacio de parámetros podemos ver los parámetros y los int --------

# intervalos de confianza de la media -------------------------------------

tamano_muestral <- 35
iteraciones <- 100
media_poblacional_A <- 5
media_poblacional_B <- 3
desv_est_poblacional <- 2

plot(media_poblacional_A, media_poblacional_B)

for(i in seq_len(iteraciones)){
  #obtengo la muestra de A
  muestra_A <- rnorm(tamano_muestral, media_poblacional_A, desv_est_poblacional)
  # Aplico funcion t de student que obtiene datos sobre la media
  t_test_A <- t.test(muestra_A)
  # Cambio el intervalo de confianza de A
  intervalo_A <- t_test_A$conf.int
  # Obtengo limites del intervalo
  LI_A <- min(intervalo_A)
  LS_A <- max(intervalo_A)
  
  # Obtengo la muestra de B
  muestra_B <- rnorm(tamano_muestral, media_poblacional_B, desv_est_poblacional)
  t_test_B <- t.test(muestra_B)
  intervalo_B <- t_test_B$conf.int
  LI_B <- min(intervalo_B)
  LS_B <- max(intervalo_B)
  
  # Creo un rectangulo con los limites de A y B
  rect(LI_A, LI_B, LS_A, LS_B)
  
}

abline(0,1, col = 2)
points(media_poblacional_A, media_poblacional_B, col = 4, pch = 20, cex = 3)

