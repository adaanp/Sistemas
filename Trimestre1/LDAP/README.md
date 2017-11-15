# Servidor LDAP.

---

## Preparar máquina.

* Configuramos el fichero `/etc/hosts` para añadir el cliente.
  * También modificamos el fichero `/etc/hostname` para poner un nuevo nombre de máquina.
    * Tenemos que reiniciar la máquina para que se modifique el *hostname*, yo la reinicié más adelante.

![img](./img/000043.png)

---

## Instalación del Servidor LDAP.

* Instalamos el módulo Yast que gestiona el servidor LDAP.

![img](./img/000044.png)

* Vamos a **Yast -> Servidor de autenticación**, y lo configuramos de esta forma:
  * Iniciar servidor LDAP -> Sí
  * Registrar dameon SLP -> No
  * Puerto abierto en el cortafuegos -> Sí -> Siguiente
  * Tipo de servidor -> autónomo -> Siguiente
  * Configuración TLS -> NO habilitar -> Siguiente
  * Tipo de BD -> hdb
  * DN base -> dc=nombre-del-alumnoXX,dc=curso1718. Donde XX es   el  número del puesto de cada uno.
  * DN administrador -> cn=Administrator
  * Añadir DN base -> Sí
  * Contraseña del administrador
  * Directorio de BD -> /var/lib/ldap
  * Usar esta BD predeterminada para clientes LDAP -> Sí -> Siguiente
  * Habilitar kerberos -> No

![img](./img/000045.png)

![img](./img/000046.png)

![img](./img/000047.png)

![img](./img/000048.png)

![img](./img/000049.png)

![img](./img/000050.png)

* Comprobamos con los siguientes comandos:
  * `slaptest -f /etc/openldap/slapd.conf`
  * `systemctl status slapd`
  * `nmap -Pn localhost | grep -P '389|636'`
  * `sudo slapcat`
  * `gq`


![img](./img/000051.png)

![img](./img/000052.png)

![img](./img/000053.png)

![img](./img/000054.png)

![img](./img/000055.png)

![img](./img/000056.png)


---

## Crear usuarios y grupos LDAP.

* Vamos a **Yast -> Usuarios y Grupos** y aplicamos el filtro *LDAP*.
  * Creamos el grupo `piratas22`.
  * Creamos los usuarios `pirata21` y `piratas22` dentro del grupo `piratas22`.

![img](./img/000057.png)

* Utilizamos la herramienta `gq` para comprobar el contenido de LDAP.

![img](./img/000058.png)

---

## Cliente LDAP.

* Configuramos el archivo `/etc/hosts` para añadir al servidor.

![img](./img/000076.png)

* Comprobamos la conexión utilizando un `nmap`.

![img](./img/000059.png)

* Utilizamos la herramienta `gq` para comprobar los usuarios.

![img](./img/000060.png)

![img](./img/000061.png)

## Instalar cliente LDAP.

* Instalamos el paquete `yast2-auth-client`.
  * Y vamos a **Yast -> LDAP y cliente Kerberos**.
  * Configuramos como la imagen y probamos la conexión.

![img](./img/000062.png)

* Comprobamos con los siguientes comandos:
  * `getent passwd pirata21`
  * `getent group piratas2`
  * `id pirata21`
  * `finger pirata21`
  * `cat /etc/passwd | grep pirata21`
  * `cat /etc/group | grep piratas2`
  * `su pirata21`

![img](./img/000063.png)

![img](./img/000064.png)

## Autenticación.

* En el cliente, cerramos sesión con el usuario en el que estemos, y iniciamos otra sesión con el usuario pirata22 (aunque en la captura salga piratas21, no entré con ese usuario ya que me daba un error, yo entré con piratas22, y luego me di cuenta que el error era porque el usuario pirata21 es en singular) y su respectiva contraseña.

![img](./img/000065.png)

* Y si todo ha ido correctamente ya estaríamos dentro.

![img](./img/000067.png)

---
