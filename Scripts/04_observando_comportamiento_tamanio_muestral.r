
# Podemos ver que el tamaño muestral presenta rendimientos decreci --------


# Distribución normal -----------------------------------------------------

tamano_muestral_max <- 500
iteraciones <- 100
media_poblacional <- 5
desv_est_poblacional <- 3
tamano_muestral <- floor(seq(10, tamano_muestral_max, length.out = iteraciones))

#inicializa vectores
desv_est_estimada <- media_estimada <- dif_cuad_media <- dif_cuad_desv_est <- vector()

for (i in seq_len(iteraciones)) {
  muestra <- rnorm(tamano_muestral[i], media_poblacional, desv_est_poblacional)
  media_estimada[i] <- mean(muestra)
  desv_est_estimada[i] <- sd(muestra)
  dif_cuad_media[i] <- (media_estimada[i] - media_poblacional)^2
  dif_cuad_desv_est[i] <- (desv_est_estimada[i] - desv_est_poblacional)^2
}


# Graficamos par la media_estimada vs temano_muestral
plot(media_estimada ~ tamano_muestral)
abline(h = media_poblacional, col = 2, lwd = 2)
# El estimador converge al parametor a medida que la media poblacional aumenta

plot(dif_cuad_media ~ tamano_muestral, type = "l")
# El desempeño del estimador aumenta al aumentar tamaño muestral


# Graficamos par la desv_est_estimada vs temano_muestral
plot(desv_est_estimada ~ tamano_muestral)
abline(h = desv_est_poblacional, col = 2, lwd = 2)

plot(dif_cuad_desv_est ~ tamano_muestral, type = "l")




# Distribución uniforme ---------------------------------------------------


tamano_muestral_max <- 500
iteraciones <- 100
maximo_poblacional <- 8
minimo_poblacional <- 3
tamano_muestral <- floor(seq(10, tamano_muestral_max, length.out = iteraciones))

maximo_estimado <- minimo_estimado <- dif_cuad_maximo <- dif_cuad_minimo <- vector()

for (i in seq_len(iteraciones)) {
  muestra <- runif(tamano_muestral[i], minimo_poblacional, maximo_poblacional)
  maximo_estimado[i] <- max(muestra)
  minimo_estimado[i] <- min(muestra)
  dif_cuad_maximo[i] <- (maximo_estimado[i] - maximo_poblacional)^2
  dif_cuad_minimo[i] <- (minimo_estimado[i] - minimo_poblacional)^2
}


plot(maximo_estimado ~ tamano_muestral)
abline(h = maximo_poblacional, col = 2, lwd = 2)

plot(dif_cuad_media ~ tamano_muestral, type = "l")


plot(minimo_estimado ~ tamano_muestral)
abline(h = minimo_poblacional, col = 2, lwd = 2)

plot(dif_cuad_desv_est ~ tamano_muestral, type = "l")


# Regresión lineal --------------------------------------------------------

tamano_muestral_max <- 500
iteraciones <- 100
beta_0 <- 1
beta_1 <- -0.3
minimo_poblacional <- 3
tamano_muestral <- floor(seq(10, tamano_muestral_max, length.out = iteraciones))

genera_x <- function(n) seq(-3, 3, length.out = n)

genera_y <- function(x, beta_0, beta_1){
  beta_1*x + beta_0 + rnorm(length(x), 0, 0.5)
}

beta_0_estimado <- beta_1_estimado <- dif_cuad_beta_0 <- dif_cuad_beta_1 <- vector()

for (i in seq_len(iteraciones)) {
  X <- genera_x(tamano_muestral[i])
  Y <- genera_y(X, beta_0, beta_1)
  betas <- coef(lm(Y ~ X))
  beta_0_estimado[i] <- betas[1]
  beta_1_estimado[i] <- betas[2]
  dif_cuad_beta_0[i] = (beta_0_estimado[i] - beta_0)^2
  dif_cuad_beta_1[i] = (beta_1_estimado[i] - beta_1)^2
}


plot(beta_0_estimado ~ tamano_muestral)
abline(h = beta_0, col = 2, lwd = 2)

plot(dif_cuad_beta_0 ~ tamano_muestral, type = "l")


plot(beta_1_estimado ~ tamano_muestral)
abline(h = beta_1, col = 2, lwd = 2)

plot(dif_cuad_beta_1 ~ tamano_muestral, type = "l")


