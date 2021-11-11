# Vagrant y VirtualBox.

---

## Instalar

* En la máquina real, instalamos el servicio vagrant utilizando el comando `sudo apt install vagrant`.

![img](./img/Selección_001.png)

* `vagrant version`, para comprobar la versión actual de Vagrant.

![img](./img/Selección_041.png)

* `VBoxManage -v`, para comprobar la versión actual de VirtualBox.

![img](./img/Selección_042.png)

## Proyecto

* Crear un directorio para nuestro proyecto vagrant, para ello creamos una carpeta con un nombre cualquiera.

![img](./img/Selección_002.png)

* Y utilizamos, dentro de esa carpeta, el comando `vagrant init`.

![img](./img/Selección_003.png)

## Imágen, caja o box

* Ahora necesitamos obtener una imagen(caja, box) de un sistema operativo. Vamos, por ejemplo, a conseguir una imagen de un Ubuntu Precise de 32 bits.
  * Utilizamos el comando `vagrant box add micaja19_ubuntu_precise32 http://files.vagrantup.com/precise32.box`.


![img](./img/Selección_004.png)

* Comprobamos que se ha creado la caja con el comando `vagrant box list`.

![img](./img/Selección_005.png)

* Cambiamos la línea `config.vm.box = "base" por config.vm.box = "micaja19_ubuntu"`

![img](./img/Selección_045.png)

## Iniciar una máquina nueva

* Vamos a la carpeta de nuestro proyecto, y utilizamos el comando `vagrant up` para iniciar nuestra máquina.

![img](./img/Selección_007.png)

> `Vagrant ssh` para conectarnos a la máquina remotamente.
![img](./img/Selección_009.png)

---

# Configuración del entorno virtual

## Carpetas compartidas

* Para identificar las carpetas compartidas dentro del entorno virtual, primero iniciamos la máquina, nos conectamos por remoto, y hacemos un `ls /vagrant`.

![img](./img/Selección_010.png)

## Redireccionamiento de puertos

* Conectados vía ssh a la máquina, hacemos un `apt update` para actualizar los repositorios.

![img](./img/Selección_011.png)

* Instalamos el apache2 usando `apt -y install apache2`.

![img](./img/Selección_012.png)

* Modificar el fichero Vagrantfile, de modo que el puerto 4567 del sistema anfitrión sea enrutado al puerto 80 del ambiente virtualizado.

![img](./img/Selección_013.png)

* `vagrant reload` para refrescar.

![img](./img/Selección_014.png)

* Comprobamos que escucha por ese puerto haciendo un `nmap -p 4500-4600 localhost`.

![img](./img/Selección_015.png)

* Debe mostrar lo siguiente:

![img](./img/Selección_016.png)

* En la máquina real, abrimos el navegador web con el URL http://127.0.0.1:4567. En realidad estamos accediendo al puerto 80 de nuestro sistema virtualizado.

![img](./img/Selección_017.png)

# Suministro

* `vagrant halt`, apagamos la MV.

![img](./img/Selección_018.png)

* `vagrant destroy` y la destruimos para volver a empezar.

![img](./img/Selección_019.png)

## Suministro mediante shell script

* Crear el script install_apache.sh, dentro del proyecto con el siguiente contenido:

```console
#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www
echo "<h1>Actividad de Vagrant</h1>" > /var/www/index.html
echo "<p>Curso201516</p>" >> /var/www/index.html
echo "<p>Nombre-del-alumno</p>" >> /var/www/index.html
```

![img](./img/Selección_020.png)

* Modificar Vagrantfile y agregar la siguiente línea a la configuración: config.vm.provision :shell, :path => "install_apache.sh"

![img](./img/Selección_024.png)

* Volvemos a crear la máquina.

![img](./img/Selección_022.png)

* Para verificar que efectivamente el servidor Apache ha sido instalado e iniciado, abrimos navegador en la máquina real con URL http://127.0.0.1:4567.

![img](./img/Selección_023.png)

## Suministro mediante Puppet

* Modificar el archivo el archivo Vagrantfile de la siguiente forma:

```console
Vagrant.configure(2) do |config|
  ...
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "default.pp"
  end
 end
```

* Crear un fichero manifests/default.pp, con las órdenes/instrucciones puppet para instalar el programa nmap. Ejemplo:

![img](./img/Selección_025.png)

![img](./img/Selección_026.png)

* Recargamos vagrant

![img](./img/Selección_027.png)

# Nuestra caja personalizada

## Preparar la MV VirtualBox

* Crear una MV VirtualBox nueva o usar una que ya tengamos.
* Instalar OpenSSH Server en la MV.
* Crear el usuario vagrant, para poder acceder a la máquina virtual por SSH. A este usuario le agregamos una clave pública para autorizar el acceso sin clave desde Vagrant.

![img](./img/Selección_029.png)

![img](./img/Selección_030.png)

* Poner clave vagrant al usuario vagrant y al usuario root.

![img](./img/Selección_031.png)

* Añadir vagrant ALL=(ALL) NOPASSWD: ALL a /etc/sudoers.

![img](./img/Selección_032.png)

* Debemos asegurarnos que tenemos instalado las VirtualBox Guest Additions con una versión compatible con el host anfitrion.

![img](./img/Selección_033.png)

## Crear la caja vagrant

* Vamos a crear una nueva carpeta mivagrantXXconmicaja, para este nuevo proyecto vagrant.
  * Ejecutamos vagrant init para crear el fichero de configuración nuevo.


![img](./img/Selección_035.png)

![img](./img/Selección_036.png)

* Localizar el nombre de nuestra máquina VirtualBox (Por ejemplo, v1-opensuse132-xfce).
  * VBoxManage list vms, comando de VirtualBox que lista las MV que tenemos.
    * Crear la caja package.box a partir de la MV.

![img](./img/Selección_037.png)

![img](./img/Selección_038.png)

* Muestro la lista de cajas disponibles, pero sólo tengo 1 porque todavía no he incluido la que acabo de crear. Finalmente, añado la nueva caja creada por mí al repositorio de vagrant.

![img](./img/Selección_039.png)

![img](./img/Selección_047.png)

![img](./img/Selección_048.png)

![img](./img/Selección_040.png)

* Pero haciendo vagrant ssh nos conectamos sin problemas con la máquina.

---
