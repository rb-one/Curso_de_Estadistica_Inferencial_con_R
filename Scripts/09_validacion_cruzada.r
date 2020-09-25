
# Hacemos la validación cruzada de nuestra red neuronal. ------------------

#install.packages("caret")
#install.packages("nnet")
#install.packages("parallel")


# Paquetes ----------------------------------------------------------------

library("caret")
library("nnet")
library("parallel")

# función de pliegue ------------------------------------------------------
rmse_fold <- function(pliegue, form, datos,  nn_size){  
  # preguntamos cuales de las filas que tenemos en nuestros datos estan en el vector pliegue
  pliegue_logic <- seq_len(nrow(datos)) %in% pliegue
  
  # Definimos los sets datos
  prueba <- subset(datos, pliegue_logic)
  entrena <- subset(datos, !pliegue_logic)  
  
  # Definimos el modelo de la red
  modelo <- nnet(form, data=entrena, size=nn_size, linout=TRUE, trace=FALSE)
  
  # Obtenemos el nombre de la variable respuesta de la red neuronal
  response_name <- setdiff(names(datos), modelo$coefnames)
  
  # Obtenemos la respuesta pronosticada
  Y_pronosticado <- predict(modelo, newdata = prueba)
  
  rmse <- RMSE(Y_pronosticado, prueba[[response_name]])
  rmse
}



# Red neuronal ------------------------------------------------------------


n_pliegues <- 20
tamano_muestral <-300
neuronas <- 10

genera_y <- function(x){
  cos(x) + rnorm(length(x), 0, 0.5)
}

X <- seq(0, 3*pi, length.out = tamano_muestral)
Y <- genera_y(X)

data.frame(X, Y) -> muestra


# validacion cruzada ------------------------------------------------------

# Usamos la funcion createFolds para crear los pliegues
createFolds(muestra$Y, k = n_pliegues) -> pliegues

# Usamos funcion mclapply para paralelizar la operacion
mclapply(
  # datos de pliegues
  pliegues,
  
  # funcion creada parte superior
  rmse_fold, 
  
  # Agregamos los parametros restantes a la funcion
  # rmse_fold(pliegue, form, datos,  nn_size)
  Y ~ X, 
  muestra, 
  nn_size = neuronas, 
  
  # Indicamos el numeros de cores
  #mc.cores = floor(detectCores()*0.8)
  mc.cores = 1
  ) -> rmse_pliegues

# convertimos la lista rmse_pliegues en un vector 
rmse_pliegues <- unlist(rmse_pliegues)

# obtenemos el promedio de los pliegues
mean(rmse_pliegues)

# graficamos
plot(rmse_pliegues, ylim = c(0, 1))
abline(h = mean(rmse_pliegues), col = 2, lwd = 4)















