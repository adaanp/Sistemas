# Docker

---

## Requisitos

* Vamos a usar MV OpenSUSE. Nos aseguraremos que tiene una versión del Kernel 3.10 o superior (uname -a).

![img](./img/000199.png)

# Instalación y primeras pruebas.

* Instalamos docker: `sudo apt-get install -y docker` o `zypper in docker`.

![img](./img/000201.png)

![img](./img/000202.png)

* Iniciamos el servicio docker: `systemctl start docker`.

![img](./img/000203.png)

* Utilizamos el comando `docker version` para que nos muestre la version instalada.

![img](./img/000204.png)

* Añadimos permisos a nuestro usuario: `usermod -a -G docker <usuario>`.

![img](./img/000205.png)

* Mostramos otra vez la versión docker:

![img](./img/000160.png)

* Salimos de nuestra sesión y volvemos a entrar, o bien reiniciamos, para que cargue la configuración.

* Comprobamos que todo funciona con los siguientes comandos ->

* `docker images`: Muestra las imágenes descargadas.

![img](./img/000206.png)

* `docker ps -a`: Muestra todos los contenedores creados.

![img](./img/000207.png)

* `docker run hello-world`: Descarga y ejecuta un contenedor con la imagen hello-world.

![img](./img/000208.png)

* `docker images`: Muestra la nueva imagen descargada.

![img](./img/000209.png)

* `docker ps -a`: Muestra el contenedor en estado *exited*.

![img](./img/000210.png)

---

## Configuración de red.

* Si queremos que nuestro contenedor tenga acceso a la red exterior, debemos activar la opción IP_FORWARD (net.ipv4.ip_forward).
  * Para openSUSE13.2 (cuando el método de configuracion de red es Wicked). Yast -> Dispositivos de red -> Encaminamiento -> Habilitar reenvío IPv4
  * Cuando la red está gestionada por Network Manager, en lugar de usar YaST debemos editar el fichero /etc/sysconfig/SuSEfirewall2 y poner FW_ROUTE="yes".

![img](./img/000211.png)

![img](./img/000212.png)

---

## Creación manual

* `docker images`: Vemos nuestras imágenes.

![img](./img/000213.png)

* `docker search debian`: Buscamos *debian* en los repositorios de Docker Hub.

![img](./img/000214.png)

* `docker pull debian:8`: Descargamos la imagen *debian:8* en local.

![img](./img/000215.png)

* `docker images`: Comprobamos que se descargó.

![img](./img/000216.png)

* `docker ps -a`: Vemos nuestros contenedores.
* `docker ps`: Vemos los contenedores en ejecución.

![img](./img/000217.png)

* Vamos a crear un contenedor con nombre mv_debian a partir de la imagen debian:8, y ejecutaremos /bin/bash: `docker run --name=mv_debian -i -t debian:8 /bin/bash`.

![img](./img/000218.png)

* Estamos dentro del contenedor.
  * Comprobamos que estamos en debian.

![img](./img/000219.png)

* Actualizamos los repositorios.

![img](./img/000220.png)

* Instalamos una aplicación, en nuestro caso, **Nginx**.

![img](./img/000221.png)

* Instalamos también el editor de texto **vi**.

![img](./img/000222.png)

* Iniciamos el servicio Nginx dentro del contenedor.

![img](./img/000223.png)

* Comprobamos los procesos.

![img](./img/000224.png)

* Creamos un fichero *html* que mostrará la página web.

![img](./img/000226.png)

* Creamos también un script con el siguiente contenido:

![img](./img/000227.png)

* Comprobamos que tenemos la máquina funcionando.

![img](./img/000228.png)

* Ahora con esto podemos crear la nueva imagen a partir de los cambios que realizamos sobre la imagen base:
  * `docker commit <CONTAINER ID> <nombre>`
  * `docker images`: Comprobamos que se creó correctamente.

![img](./img/000229.png)

```
docker ps
docker stop con_debian  # Paramos el contenedor
docker ps
docker ps -a           # Vemos el contenedor parado
docker rm IDcontenedor # Eliminamos el contenedor
docker ps -a
```

![img](./img/000230.png)

![img](./img/000231.png)

![img](./img/000232.png)

---

## Crear contenedor Nginx.

* Iniciemos el contenedor de la siguiente manera:
```
docker ps
docker ps -a
docker run --name=con_nginx -p 80 -t dvarrui/nginx /root/server.sh
Booting Nginx!
Waiting...
```

![img](./img/000233.png)

![img](./img/000235.png)

* `docker ps`: Nos muestra los contenedores en ejecución. Podemos apreciar que la última columna nos indica que el puerto 80 del contenedor está redireccionado a un puerto local 0.0.0.0.:NNNNNN->80/tcp.

![img](./img/000236.png)

* Abrir navegador web y poner URL 0.0.0.0.:NNNNNN. De esta forma nos conectaremos con el servidor Nginx que se está ejecutando dentro del contenedor.

![img](./img/000237.png)

* Paramos el contenedor y lo eliminamos.

```
docker ps
docker stop con_nginx
docker ps
docker ps -a
docker rm con_nginx
docker ps -a
```

![img](./img/000238.png)

---

## Crear un contenedor con Dockerfile

* Comprobaciones iniciales:

```
docker images
docker ps
docker ps -a
```

![img](./img/000239.png)

![img](./img/000240.png)

![img](./img/000241.png)

* Crear directorio /home/nombre-alumno/dockerXX, poner dentro los siguientes ficheros:
  * Dockerfile
  * holamundo.html
  * server.sh

![img](./img/000242.png)

![img](./img/000156.png)

* Crear el fichero **Dockerfile** con el siguiente contenido:
```
FROM debian:8

MAINTAINER Nombre-del-Alumno 1.0

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y nginx
RUN apt-get install -y vim

COPY holamundo.html /var/www/html
RUN chmod 666 /var/www/html/holamundo.html

COPY server.sh /root
RUN chmod +x /root/server.sh

EXPOSE 80

CMD ["/root/server.sh"]
```

![img](./img/000155.png)

* `docker images`: Consultamos las imágenes disponibles.

![img](./img/000243.png)

* `docker build -t adan/nginx2 .`: Construimos la imagen a partir del Dockerfile

![img](./img/000244.png)

* `docker ps -a`: Comprobamos.

![img](./img/000245.png)

* A continuación vamos a crear un contenedor con el nombre con_nginx2, a partir de la imagen adan/nginx2, y queremos que este contenedor ejecute el programa /root/server.sh.
  * `docker run --name con_nginx2 -p 80 -t dvarrui/nginx2 /root/server.sh`

![img](./img/000162.png)

* Comprobar en el navegador URL: http://localhost:PORTNUMBER

![img](./img/000246.png)

* Comprobar en el navegador URL: http://localhost:PORTNUMBER/holamundo.html

* El PORTNUMBER lo averigüamos con el comando `docker ps -a`

![img](./img/000245.png)

![img](./img/000247.png)

---

## Migrar las imágenes de docker a otro servidor

* `docker ps`, muestra los contenedores que tengo en ejecución.

![img](./img/000248.png)

* `docker commit -p CONTAINERID container-backup`, grabar una imagen de nombre "container-backup" a partir del contenedor CONTAINERID.

![img](./img/000249.png)

* Exportar imagen docker a fichero:
  * `docker save -o ~/containerXX-backup.tar containerXX-backup`, guardamos la imagen "container-backup" en un fichero tar.

![img](./img/000250.png)

* Cargamos la imagen que me pasó Sergio para comprobar que funcionan en otro servidor.
  * `docker load -i ~/<nombre-imagen>`

![img](./img/000254.png)

* `docker images`

![img](./img/000255.png)

---
