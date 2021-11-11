# Puppet

---

## Configuración

* Vamos a usar 3 MV's con las siguientes configuraciones:
  * MV1 - master: Dará las órdenes de instalación/configuración a los clientes.
      * Configuración OpenSUSE.
      * IP estática 172.18.19.100
      * Nombre del equipo: master19
      * Dominio: curso1718

  * MV2 - cliente 1: recibe órdenes del master.
      *  Configuración OpenSUSE.
      *  IP estática 172.18.19.101
      *  Nombre del equipo: cli1alu19
      *  Dominio: curso1718
  * MV3 - client2: recibe órdenes del master.
      *  Configuración SO Windows 10.
      *  IP estática 172.18.19.102
      *  Nombre Netbios: cli2alu19
      *  Nombre del equipo: cli2alu19

* Configurar /etc/hosts
  * Cada MV debe tener configurada en su /etc/hosts al resto de hosts, para poder hacer ping entre ellas usando los nombres. Con este fichero obtenemos resolución de nombres para nuestras propias MV's sin tener un servidor DNS

* Comprobar las configuraciones.
  ```
  date
  ip a
  route -n
  host www.google.es
  hostname -a
  hostname -f               
  hostname -d               
  tail -n 5 /etc/hosts
  ping master19
  ping master19.curso1718
  ping cli1alu19
  ping cli1alu19.curso1718
  ping cli2alu19
  ```
![img](./img/000269.png)

![img](./img/000270.png)

![img](./img/000271.png)

![img](./img/000272.png)

![img](./img/000273.png)

![img](./img/000274.png)

![img](./img/000275.png)

![img](./img/000281.png)

* En Windows comprobamos con:

```
date
ipconfig
route PRINT
nslookup www.google.es
ping masterXX
ping masterXX.curso1718
ping cli1aluXX
ping cli1aluXX.curso1718
ping cli2aluXX
```

![img](./img/000276.png)

![img](./img/000277.png)

![img](./img/000278.png)

![img](./img/000279.png)

![img](./img/000280.png)

---

## Primera versión del fichero pp

* Instalamos Puppet Master en la MV masterXX:

![img](./img/000282.png)

* `systemctl status puppetmaster`: Consultar el estado del servicio.

* `systemctl enable puppetmaster`: Permitir que el servicio se inicie automáticamente en el inicio de la máquina.

![img](./img/000283.png)

* `systemctl start puppetmaster`: Iniciar el servicio.

* `systemctl status puppetmaster`: Consultar el estado del servicio.

![img](./img/000284.png)

* Preparamos los ficheros/directorios en el master:
```
mkdir /etc/puppet/files
touch /etc/puppet/files/readme.txt
mkdir /etc/puppet/manifests
touch /etc/puppet/manifests/site.pp
mkdir /etc/puppet/manifests/classes
touch /etc/puppet/manifests/classes/hostlinux1.pp
```

![img](./img/000285.png)

![img](./img/000286.png)

![img](./img/000287.png)

---

## site.pp

* Contenido de nuestro site.pp:

![img](./img/000288.png)

## hostlinux1.pp

* Contenido para /etc/puppet/manifests/classes/hostlinux1.pp:

![img](./img/000289.png)

* tree /etc/puppet, consultar los ficheros/directorios que tenemos creado.

![img](./img/000290.png)

* Comprobar que la ruta /var/lib/puppet tiene usuario/grupo propietario puppet.

![img](./img/000291.png)

* Reiniciamos el servicio systemctl restart puppetmaster.

![img](./img/000292.png)

* Comprobamos que el servicio está en ejecución de forma correcta.
  * systemctl status puppetmaster
  * netstat -ntap |grep ruby

![img](./img/000293.png)

* Abrir el cortafuegos para el servicio.

![img](./img/000294.png)

---

## Instalación y configuración del cliente1

* Vamos a la MV cliente 1.
* Instalar el Agente Puppet `zypper install rubygem-puppet`

![img](./img/000331.png)

* El cliente puppet debe ser informado de quien será su master. Para ello, vamos a configurar `/etc/puppet/puppet.conf`:

![img](./img/000332.png)

![img](./img/000333.png)

* Comprobar que la ruta /var/lib/puppet tiene como usuario/grupo propietario puppet.

![img](./img/000334.png)

* `systemctl status puppet`: Ver el estado del servicio puppet.

![img](./img/000335.png)

* `systemctl enable puppet`: Activar el servicio en cada reinicio de la máquina.

![img](./img/000336.png)

* `systemctl start puppet`: Iniciar el servicio puppet.
* `systemctl status puppet`: Ver el estado del servicio puppet.

![img](./img/000337.png)

* `netstat -ntap |grep ruby`: Muestra los servicios conectados a cada puerto.

![img](./img/000338.png)

---

## Certificados

* Vamos a la MV master.
* Nos aseguramos de que somos el usuario root.
* `puppet cert list`, consultamos las peticiones pendientes de unión al master:

![img](./img/000339.png)

* `puppet cert sign "cli1alu19.curso1718"`, aceptar al nuevo cliente desde el master:

![img](./img/000340.png)

* `puppet cert print cli1alu42.curso1617`, mostramos el certificado.

![img](./img/000342.png)

# Comprobación

* Vamos a cliente1
* Reiniciamos la máquina y/o el servicio Puppet.

![img](./img/000343.png)

* Comprobar que los cambios configurados en Puppet se han realizado.
* Nos aseguramos de que somos el usuario root.
* Ejecutar comando para comprobar posibles errores:
  * `puppet agent --test`
        o también `puppet agent --server master42.curso1718 --test`

![img](./img/000344.png)

* En caso de tener errores:
  * Para ver el detalle de los errores, podemos reiniciar el servicio puppet en el cliente, y consultar el archivo de log del cliente: `tail /var/log/puppet/puppet.log`.
  * Puede ser que tengamos algún mensaje de error de configuración del fichero `/etc/puppet/manifests/site.pp` del master. En tal caso, ir a los ficheros del master y corregir los errores de sintáxis.

---

##  Segunda versión del fichero pp

* Contenido para /etc/puppet/manifests/classes/hostlinux2.pp:

```
class hostlinux2 {
  package { "tree": ensure => installed }
  package { "traceroute": ensure => installed }
  package { "geany": ensure => installed }

  group { "piratas": ensure => "present", }
  group { "admin": ensure => "present", }

  user { 'barbaroja':
    home => '/home/barbaroja',
    shell => '/bin/bash',
    password => 'poner-una-clave-encriptada',
    groups => ['piratas','admin','root']
  }

  file { "/home/barbaroja":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 750
  }

  file { "/home/barbaroja/share":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 750
  }

  file { "/home/barbaroja/share/private":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 700
  }

  file { "/home/barbaroja/share/public":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 755
  }
}
```

* Modificar `/etc/puppet/manifests/site.pp` para que se use la configuración de hostlinux2 el lugar de la anterior:

```
import "classes/*"

node default {
  include hostlinux2
}
```

* Ejecutar tree /etc/puppet en el servidor, para comprobar ficheros y directorios.

![img](./img/000345.png)

* Vamos al cliente1 y comprobamos que se hayan aplicado los cambios solicitados.

![img](./img/000004.png)

---

# Cliente puppet Windows

* Vamos a la MV master.
* Vamos a crear una configuración puppet para las máquinas windows, dentro del fichero.
* Crear /etc/puppet/manifests/classes/hostwindows3.pp, con el siguiente contenido:

```
class hostwindows3 {
  file {'C:\warning.txt':
    ensure => 'present',
    content => "Hola Mundo Puppet!",
  }
}
```

![img](./img/000005.png)

* Ahora vamos a modificar el fichero site.pp del master, para que tenga en cuenta la configuración de clientes GNU/Linux y clientes Windows, de modo diferenciado:

![img](./img/000006.png)

* En el servidor ejecutamos tree /etc/puppet, para confirmar que tenemos los nuevos archivos.

![img](./img/000007.png)

* Reiniciamos el servicio PuppetMaster.

![img](./img/000008.png)

* Debemos instalar la misma versión de puppet en master y en los clientes.

![img](./img/000009.png)

* Descargamos e instalamos la versión de Agente Puppet para Windows similar al Puppet Master.

![img](./img/000011.png)

![img](./img/000010.png)

* Debemos aceptar el certificado en el master para este nuevo cliente. Consultar apartado anterior y repetir los pasos para este nuevo cliente.

![img](./img/000012.png)

![img](./img/000013.png)

![img](./img/000014.png)

* Vamos al cliente2.

* Iniciar consola puppet como administrador y probar los comandos:
  * puppet agent --configprint server, debe mostrar el nombre del servidor puppet. En nuestro ejemplo debe ser masterXX.curso1718.

![img](./img/000015.png)

  * puppet agent --server masterXX.curso1617 --test: Comprobar el estado del agente puppet.

![img](./img/000018.png)

  * puppet agent -t --debug --verbose: Comprobar el estado del agente puppet.

![img](./img/000016.png)

  * facter: Para consultar datos de la máquina windows, como por ejemplo la versión de puppet del cliente.

  ![img](./img/000017.png)


  * puppet resource user nombre-alumno1: Para ver la configuración puppet del usuario.

![img](./img/000019.png)

  * puppet resource file c:\Users: Para var la configuración puppet de la carpeta.

![img](./img/000020.png)

* Configuramos en el master el fichero `/etc/puppet/manifests/classes/hostwindows4.pp` para el cliente Windows:

```
class hostwindows4 {
  user { 'soldado1':
    ensure => 'present',
    groups => ['Administradores'],
  }

  user { 'aldeano1':
    ensure => 'present',
    groups => ['Usuarios'],
  }
}
```

![img](./img/000021.png)

* Crear un nuevo fichero de configuración para la máquina cliente Windows con el  nombre`/etc/puppet/manifests/classes/hostalumno5.pp`.
Incluir configuraciones elegidas por el alumno y probarlas.

![img](./img/000023.png)

![img](./img/000024.png)

## Comprobación

![img](./img/000022.png)

![img](./img/000025.png)

---
