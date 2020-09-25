
# Red neuronal de pronóstico con datos reales. ----------------------------

# Paquetes ----------------------------------------------------------------

library("dplyr")
library("saber")
library("nnet")

data("SB11_20112")


tamano_muestral <- 2000

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


