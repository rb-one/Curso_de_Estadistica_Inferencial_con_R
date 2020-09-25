
# Hacemos la validación cruzada de nuestra red neuronal. ------------------

# Paquetes ----------------------------------------------------------------

library("saber")
library("nnet")
library("caret")
library("parallel")

# función de pliegue ------------------------------------------------------

rmse_fold <- function(pliegue, form, datos,  nn_size){
  pliegue_logic <- seq_len(nrow(datos)) %in% pliegue
  entrena <- subset(datos, !pliegue_logic)
  prueba <- subset(datos, pliegue_logic)
  modelo <- nnet(form, data = datos, size = nn_size, linout = TRUE, trace = FALSE)
  response_name <- setdiff(names(datos), modelo$coefnames)
  Y_pronosticado <- predict(modelo, newdata = prueba)
  rmse <- RMSE(Y_pronosticado, prueba[[response_name]])
  rmse
}


calcula_rmse_tam <- function(tamano_muestral){
  
  indices_muestra <- seq_len(nrow(SB11_20112)) %in% sample(seq_len(nrow(SB11_20112)), tamano_muestral)
  
  muestra <- subset(SB11_20112, subset = indices_muestra, select = variables)
  muestra <- na.omit(muestra)
  
  createFolds(muestra$MATEMATICAS_PUNT, k = n_pliegues) -> pliegues
  
  lapply(
    pliegues,
    rmse_fold, 
    MATEMATICAS_PUNT ~., 
    muestra, 
    nn_size = neuronas 
  ) -> rmse_pliegues
  mean(unlist(rmse_pliegues))
}

  
  # convierto rmse_pliegues a un vector con unlist()
  rmse_pliegues <- unlist(rmse_pliegues)
  
  # mido la media
  mean(rmse_pliegues)
}


# Red neuronal ------------------------------------------------------------

iteraciones <- 20
tamano_muestral_max <- 5000
tamano_muestral <- floor(seq(500, tamano_muestral_max, length.out = iteraciones))
n_pliegues <- 4
neuronas <- 20

data("SB11_20112")

c(
  "ECON_PERSONAS_HOGAR",
  "ECON_CUARTOS",
  "ECON_SN_LAVADORA",
  "ECON_SN_NEVERA",
  "ECON_SN_HORNO",
  "ECON_SN_DVD",
  "ECON_SN_MICROHONDAS",
  "ECON_SN_AUTOMOVIL",
  "MATEMATICAS_PUNT"
) -> variables




mclapply(
  tamano_muestral, 
  calcula_rmse_tam, 
  #mc.cores = floor(detectCores()*0.8)
  mc.cores = 1 
) -> rmse_por_tam



# Graficamos
plot(rmse_pliegues, ylim = c(0, 14))
abline(h = mean(rmse_pliegues), col = 2, lwd = 2)

