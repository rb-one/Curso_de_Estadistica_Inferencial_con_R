
# Red neuronal de pronóstico con datos reales. ----------------------------

# Paquetes ----------------------------------------------------------------

library("dplyr")
library("saber")
library("nnet")

data("SB11_20112")


tamano_muestral <- 2000

c(
  "ECON_PERSONAS_HOGAR",
  "FAMI_COD_EDUCA_PADRE",
  "FAMI_COD_EDUCA_MADRE",
  "ESTU_EDAD",
  "ECON_CUARTOS",
  "FISICA_PUNT",
  "ECON_SN_INTERNET",
  "FAMI_ING_FMILIAR_MENSUAL",
  "MATEMATICAS_PUNT"
) -> variables

# Creo una mascara booleanada indices_muestra
indices_muestra <- seq_len(nrow(SB11_20112)) %in% 
                      sample(seq_len(nrow(SB11_20112)), tamano_muestral)

# Obtenemos un subset muestra usando los indices
muestra <- subset(SB11_20112, subset = indices_muestra, select = variables)
muestra <- na.omit(muestra)

# Generamos la red neuronal
red_neuronal <- nnet(MATEMATICAS_PUNT ~., data=muestra, size=10, linout=TRUE) 
# Y ~.indica a nnet pronosticar este dato (MATEMATICAS_PUNT ~.) 
# respecto a los demas datos


# Graficamos
plot(muestra$MATEMATICAS_PUNT ~ predict(red_neuronal))
lines(1:100, col = 2, lwd = 2)

pairs(SB11_20112[,9:10])