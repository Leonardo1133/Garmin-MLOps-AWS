# Garmin Prediction Model
Este Proyecto se trata de un modelo predictivo sobre nuestra condicion fisica usando los datos que entrega nuestro dispositivo Garmin. 

Crearemos una primera iteracion del modelo de condicion fisica, y lo implementaremos en AWS para poder consumirlo desde un API y asi desde cualquier navegador web. De esta forma, tenemos un end to end rapidamente, repartiendo esfuerzos en cada una de las partes del proyecto.

# MLOps

Para el despliegue de esta arquitectura y la infraestructura correspondiente usaremos Amazon Web Services. Crearemos una arquitectura usando el framework MLOPS para poner en produccion nuestro modelo de ML generado en la etapa previa, y asi poder consumirlo desde una API. En la figura a continuacion se esquematiza un diagrama que muestra el ciclo de vida del modelo end to end.

## 1) Data
Descargamos los datos RAW que entrega la API de Garmin Connect en formato JSON, los guardaremos en un bucket s3 y aplicamos algunas transformaciones para llevarlo a un formato CSV. Para el download de los datos usamos como referencia el siguiente repositorio:

https://github.com/petergardfjall/garminexport/blob/master/README.md

## 2) ModelBuild
Es un repositorio en codeCommit que organiza la construccion del modelo. Se encarga de desplegar y orquestar cada uno de los pasos de la creacion del modelo:  

- Preprocessing 
- Trainig
- Validation
- Model Register

## 3) Model Artifact
Una vez entrenado, se almacena en un bucket S3 para posteriormente, ser llamado por la lambda que crea el endpoint a parit de el.

## 4) ModelDeploy
Es un repositorio en codeCommit que despliega toda la infraestructura y servicios necesarios para desplegar y consumir el endpoint del modelo: 

- Model Endpoint
- Lambda Start Endpoint
- EventBridge (start lambda)
- API Gateway

Ambos repositorios: ModelBuil y ModelDeploy utilizan IAC (Infrastructure as code) para el despliegue de la arquitectura, en especifico se usa cloudFormation. 

## 5) Feature Store
Feature store es un almacen o repositorio de nuestros datos de entrenamiento, ya estan listos para ser usados. Esto se realiza en la primera etapa de construccion del modelo. En caso de un reentrenamiento pueden crearse distintas versiones de estos datos y conservarlos en el FS.

![image](https://user-images.githubusercontent.com/42939877/169722217-467b8d04-8e7e-4656-be9d-c24f32a48b7e.png)
