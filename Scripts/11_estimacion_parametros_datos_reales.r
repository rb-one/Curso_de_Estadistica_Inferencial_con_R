
# Correr nuestro código de estimación puntual con datos reales del --------

# https://www.icfes.gov.co/nl/investigadores-y-estudiantes-posgrad --------

# https://github.com/nebulae-co/saber -------------------------------------




# Paquetes ----------------------------------------------------------------


# install.packages("devtools")
# devtools::install_github("nebulae-co/saber")

library("saber")


# carga de datos ----------------------------------------------------------
# data("SB11_20111") # 31707

# Carga los datos del segundo semestre 2012
data("SB11_20112")


# SB11_20112 %>% names()


iteraciones <- 38
tamano_muestral <- 27

# Grafica inicial para centrar la grafica
plot(
  mean(SB11_20112$MATEMATICAS_PUNT),
  sd(SB11_20112$MATEMATICAS_PUNT),
  pch = 20,
  cex = 4,
  col = "white"
)

# Agregamos un punto por
for(i in seq_len(iteraciones)){
  points(
    mean(sample(SB11_20112$MATEMATICAS_PUNT, tamano_muestral)),
    sd(sample(SB11_20112$MATEMATICAS_PUNT, tamano_muestral)),
    pch = 20
    
  )
}

# Agregamos el punto del parametro
points(
  mean(SB11_20112$MATEMATICAS_PUNT),
  sd(SB11_20112$MATEMATICAS_PUNT),
  pch = 20,
  cex = 4,
  col = 2
)





# tidy approach -----------------------------------------------------------


library("dplyr")
library("ggplot2")
library("purrr")

colores_platzi <- c("#78D92A", "#002E4E", "#058ECD", "#ED2B05", "#F4F7F4")

tibble(
  muestras = replicate(iteraciones, sample(SB11_20112[["MATEMATICAS_PUNT"]], tamano_muestral), simplify = FALSE),
  medias = map_dbl(muestras, mean),
  desv = map_dbl(muestras, sd),
) %>% ggplot + 
  geom_point(aes(x = medias, y = desv)) +
  annotate(
    geom = "point", 
    x = mean(SB11_20112[["MATEMATICAS_PUNT"]]), 
    y = sd(SB11_20112[["MATEMATICAS_PUNT"]]),
    size = 4,
    colour = colores_platzi[4]) +
  theme_minimal()


