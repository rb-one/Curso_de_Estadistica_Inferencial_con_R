# Revisemos la potencia de una prueba. ------------------------------------


# wmw con dos gamas -------------------------------------------------------

# La media de una gamma es shape/rate, vamos a mover el shape -------------

tamano_muestral <- 50
iteraciones <- 80
dif_media_ini <- 0
dif_media_fin <- 2
media_x <- 1
n_pasos <- 50
umbral_significancia <- 0.05

## la idea es ir cambiando la media para ver en que prueba localiza que hay una diferencia
## de medias, la media_x sera constante y media_y sera movil.P

dif_medias <- seq(dif_media_ini, dif_media_fin, length.out = n_pasos)


# prueba wmw con dos gamas (no parametrica) --------------------------------

# La media de una gamma es shape/rate, vamos a mover el shape --------------

# prueba wmw ---------------------------------------------------------------


potencia_wmw <- vector()

for(k in seq_along(dif_medias)){ 
  
  sim_shape <- media_x + dif_medias[k]
  
  p_valores <- vector()
  
  for(i in seq_len(iteraciones)){
    x <- rgamma(tamano_muestral, media_x, 1)
    y <- rgamma(tamano_muestral, sim_shape, 1)
    p_valores[i] <- wilcox.test(x, y)$p.value
    
  }
  
  potencia_wmw[k] <- mean(p_valores < umbral_significancia)
  
}

# prueba t -----------------------------------------------------------------



potencia_t <- vector()

for(k in seq_along(dif_medias)){ 
  
  sim_shape <-  media_x + dif_medias[k] 
  
  p_valores <- vector()
  
  for(i in seq_len(iteraciones)){
    x <- rgamma(tamano_muestral, media_x, 1)
    y <- rgamma(tamano_muestral, sim_shape, 1)
    p_valores[i] <- t.test(x, y)$p.value
    
  }
  
  potencia_t[k] <- mean(p_valores < umbral_significancia)
  
}


plot(dif_medias, potencia_wmw, ylim = c(0, 1), col = 4, type = "l")
lines(dif_medias, potencia_t, col = )
