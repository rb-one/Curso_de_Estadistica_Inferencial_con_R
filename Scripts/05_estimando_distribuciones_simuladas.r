

# ECDF para todos! --------------------------------------------------------



# Kernel ------------------------------------------------------------------


# Distribución normal -----------------------------------------------------

tamano_muestral <- 100
media <- 5
desv <- 3
iteraciones <- 75

x <- seq(-5, 15, length.out = 100)

Y <- rnorm(tamano_muestral, media, desv)

estimador_kernel <- density(Y)

plot(estimador_kernel)
lines(x = x, y = dnorm(x, media, desv), col = 2, lwd = 2)


plot(estimador_kernel)
for(i in seq_len(iteraciones)){
  Y <- rnorm(tamano_muestral, media, desv)
  
  estimador_kernel <- density(Y)
  
  lines(estimador_kernel)
  
}
lines(x = x, y = dnorm(x, media, desv), col = 2, lwd = 2)



# Distribución uniforme ---------------------------------------------------


tamano_muestral <- 100
a <- 3
b <- 8
iteraciones <- 75

x <- seq(2, 9, length.out = 100)

Y <- runif(tamano_muestral, a, b)

estimador_kernel <- density(Y)

plot(estimador_kernel)
lines(x = x, y = dunif(x, a, b), col = 2, lwd = 2)



plot(estimador_kernel)
for(i in seq_len(iteraciones)){
  Y <- runif(tamano_muestral, a, b)
  
  estimador_kernel <- density(Y)
  
  lines(estimador_kernel)
  
}
lines(x = x, y = dunif(x, a, b), col = 2, lwd = 2)



# ECDF --------------------------------------------------------------------

# distribución normal -----------------------------------------------------


tamano_muestral <- 100
media <- 5
desv <- 3
iteraciones <- 75

x <- seq(-5, 15, length.out = 100)

Y <- rnorm(tamano_muestral, media, desv)

estimador_ecdf <- ecdf(Y)

plot(estimador_ecdf, pch = "", verticals = TRUE)
lines(x = x, y = pnorm(x, media, desv), col = 2, lwd = 2)



plot(estimador_ecdf, pch = "", verticals = TRUE)
for(i in seq_len(iteraciones)){
  Y <- rnorm(tamano_muestral, media, desv)
  estimador_ecdf <- ecdf(Y)
  lines(estimador_ecdf, pch = "", verticals = TRUE)
}
lines(x = x, y = pnorm(x, media, desv), col = 2, lwd = 2)



# Distribución uniforme ---------------------------------------------------

tamano_muestral <- 1000
a <- 2
b <- 8
iteraciones <- 75

x <- seq(-5, 15, length.out = 100)

Y <- runif(tamano_muestral, a, b)

estimador_ecdf <- ecdf(Y)

plot(estimador_ecdf, pch = "", verticals = TRUE)
lines(x = x, y = punif(x, a, b), col = 2, lwd = 2)



plot(estimador_ecdf, pch = "", verticals = TRUE)
for(i in 1:iteraciones){
  Y <- runif(tamano_muestral, a, b)
  
  estimador_ecdf <- ecdf(Y)
  
  lines(estimador_ecdf, pch = "", verticals = TRUE)
  
}
lines(x = x, y = punif(x, a, b), col = 2, lwd = 2)

