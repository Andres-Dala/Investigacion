## Definición del problema
Sea el proceso \{y_t\}  con t=1,2,...,n una serie de tiempo lineal cualquiera, habitualmente se busca predecir con la mayor precisión posible los valores futuros y_{n+m} con m=1,2,...h esto se puede lograr ajustando los datos a un modelo de predicción ARIMA no estacional [3] siendo procesos que en general crean un buen ajuste a los datos, por esta razón los estadísticos George Box y Gwilym Jenkins en 1970 propusieron el método Box-Jenkins para la predicción con dichos modelos el cual se basa en tres etapas iterativas: selección del modelo, estimación de parámetros y verificación de modelos, así como lo muestra Hyndman en  [2].

De manera similar estos modelos también son capaces de describir datos estacionales, esto es agregando una componente estacional en el modelo el cual se denota como SARIMA (Multiplicative seasonal autoregressive integrated moving average) que se muestra en \ref{sarima}, sin embargo podemos redefinir los modelos antes mencionados a un enfoque bayesiano así como se hace en \ref{sarimab}, por consiguiente es natural preguntarse qué método usar para la predicción a la hora de ajustar los datos a un Modelo SARIMA Bayesiano, lo que conlleva al problema central de este estudio. El objeto de este estudio es proponer una nueva metodología de predicción análoga al método de Box-Jenkins dirigido a estos modelos desde una perspectiva bayesiana.


Cabe destacar que la nueva metodología si bien es cierto es análoga al metodo Box-Jenkins, cada componente usará herramientas detalladas del *Bayesian Workflow* propuesto en [4] el cual maneja muy bien la estimación de parámetros de modelos y la incertidumbre en los datos.

Por ultimo, una vez establecido el nuevo método se realizarán tres diferentes pruebas en tres conjuntos de datos que miden el IPC en Honduras de 1980 al 2018, la tasa de cambio de divisas entre Alemania y Reino Unido de 1984 a 1991 y la afluencia de turistas en Australia de 1995 al 2015, cada uno de estos conjuntos se encuentran en el paquete **bayesforecast** , finalmente con los resultados de dichas pruebas se demostrará la funcionalidad del nuevo método propuesto.

## Referencias


Hyndman, R.J., \& Athanasopoulos, G. (2018).  *Forecasting: principles and practice*. 2nd edition, OTexts: Melbourne, Australia. OTexts.com/fpp2. Accessed on February 17, 2021.


Rob J. Hyndman (2002). *Box-Jenkins modelling*,  In: Informed Student Guide to Management Science, ed., Hans Daellenbach and Robert Flood, Thomson: London. \url{https://robjhyndman.com/papers/BoxJenkins.pdf}


Rob J Hyndman (2002). *ARIMA processes*. In: Informed Student Guide to Management Science, ed., Hans Daellenbach and Robert Flood, Thomson: London. \url{https://robjhyndman.com/papers/ARIMA.pdf}


Andrew Gelman, Aki Vehtari, Daniel Simpson, Charles C. Margossian, Bob Carpenter, Yuling Yao, Lauren Kennedy, Jonah Gabry, Paul-Christian Bürkner, Martin Modrák (2020). *Bayesian Workflow*, \url{https://arxiv.org/abs/2011.01808} 


Carpenter, B., Gelman, A., Hoffman, M., Lee, D., Goodrich, B., Betancourt, M., Brubaker, M., Guo, J., Li, P., \& Riddell, A. (2017). *Stan: A Probabilistic Programming Language*. Journal of Statistical Software, 76(1), 1 - 32. doi: \url{http://dx.doi.org/10.18637/jss.v076.i01}


Hyndman, R., \& Khandakar, Y. (2008). *Automatic Time Series Forecasting: The forecast Package for R*. Journal of Statistical Software, 27(3), 1 - 22. doi: \url{http://dx.doi.org/10.18637/jss.v027.i03}


Robert H. Shumway, David S. Stoffer (2017). *Time Series Analysis and Its Applications*, Fourth Edition.


Matamoros A., Cruz C., Dala A., Hyndman R., O'Hara-Wild M. (2021). **bayesforecast:** *Bayesian Time Series Modeling with Stan* version 1.0.1, \url{https://CRAN.R-project.org/package=bayesforecast}
