
# Hacemos un bootstrapping para nuestra regresión lineal. -----------------


# Bootstrapping -----------------------------------------------------------


tamano_muestral <- 23
iteraciones <- 1000
beta_0 <- 1
beta_1 <- -0.3
desv_est_error <- 0.5

genera_x <- function(n) seq(-3, 3, length.out = n)

genera_y <- function(x, beta_0, beta_1){
  beta_1*x + beta_0 + rnorm(length(x), 0, desv_est_error)
}

#los datos se vuelven fijos para el ejercicio
datos_x <- geno_muestral)
datos_y <- genera_y(datos_x, beta_0, beta_1)

#hacemos la regresion con lm (linear model)
lm(datos_y ~ datos_x) -> modelo
coefficients(modelo) -> coeficientes_muestrales

# obtenemos intervalos de confianza con confint
confint(modelo)


#inicializamos vectores
beta_0_estimado <- beta_1_estimado <- vector()


for(i in seq_len(iteraciones)){
  # Tomamos una muesta con sample(numeros, tamaño, reemplazo(datos repetidos)
  muestra <- sample(seq_along(datos_x), length(datos_x), replace = TRUE)
  
  # Usando los valores aleatorios y repetitivos de la variable "muestra" 
  # como indices tomamos una muestra datos de la variable "datos_x"
  muestra_x <- datos_x[muestra]

  # Repetimos el procedimiento para muestra_y
  muestra_y <- datos_y[muestra]
  
  # Hacemos un modelo lineal de con las submuestras
  lm(muestra_y ~ muestra_x) -> modelo
  
  # Obtenemos sus coeficientes
  coeficientes <- coefficients(modelo)
  
  # Guardamos los coeficientes estimados
  beta_0_estimado[i] <- coeficientes[1]
  beta_1_estimado[i] <- coeficientes[2]
}


# Creamos un DataFrame con los datos

data.frame(
  limite = c("inferior", "superior"),
  beta_0 = quantile(beta_0_estimado, c(0.025, 0.975)),
  beta_1 = quantile(beta_1_estimado, c(0.025, 0.975))
) -> intervalo_bootstrapping

intervalo_bootstrapping

# Hacemos el plot
plot(beta_0, beta_1)

points(beta_0_estimado, beta_1_estimado)
points(coeficientes_muestrales[1], coeficientes_muestrales[2], pch = 20, col = 4, cex = 3)
points(beta_0, beta_1, pch = 20, col = 2, cex = 3)
# Graficamos un rectangolo (nuestro intervalo de confianza)
rect(
  intervalo_bootstrapping$beta_0[1], 
  intervalo_bootstrapping$beta_1[1],
  intervalo_bootstrapping$beta_0[2],
  intervalo_bootstrapping$beta_1[2],
  border = 4, lwd = 2)
















