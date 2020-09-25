# Vamos a jugar con datos simulados. Escojan sus

# Distribucion normal estandar
y <- rnorm(100)
plot(density(y))

# Distribucion normal de media cinco y desviacion estandar 3
y <- rnorm(100,5,3)
plot(density(y))

# Distribucion uniforme 0,1
y <- runif(100)
plot(density(y))

# Distribucion uniforme a=3, b=8
y <- runif(100,3,8)
plot(density(y))

# Ejemplo de la edad y el lugar

data.frame(
  Edad = rnorm(50, 10, 1.2),
  Lugar = "Escuela"
) -> escuela

data.frame(
  Edad = rnorm(45, 15, 1.9),
  Lugar = "Preparatoria"
) -> prepa

data.frame(
  Edad = rnorm(80, 21, 2.5),
  Lugar = "Universidad"
) -> universidad

rbind(escuela, prepa, universidad) -> edad_lugar

boxplot(Edad ~ Lugar, data = edad_lugar)


# Modelo lineal

X <-seq(0, 3*pi, length.out = 100)
Y <- -0.3*X + 1 + rnorm(100,0,0.5)
Z <- -0.3*X + 1

data.frame(X,Y,Z) -> datos_lineal
plot(Y ~ X, data = datos_lineal )
lines(Z ~ X, data = datos_lineal, col = 2, lwd = 2)

# Modelo no lineal
X <-seq(0, 3*pi, length.out = 100)
Y <- cos(x) + rnorm(100,0,0.5)
Z <- data.frame(X,Y,Z) -> datos_no_lineal + 1

data.frame(X,Y,Z) -> datos_no_lineal
plot(Y ~ X, data = datos_no_lineal )
lines(Z ~ X, data = datos_no_lineal, col = 2, lwd = 2)

