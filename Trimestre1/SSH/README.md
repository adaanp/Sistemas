# Acceso remoto **SSH** :octocat:

<hr>

# Configuración

* Lo primero es tener 3 máquinas.
  1. Máquina *servidor*.
      - Con OpenSuse, IP `172.18.19.31`, y hostname `ssh-server19`.
  2.  Máquina *cliente 1*.
      - Con OpenSuse, IP `172.18.19.32`, y hostname `ssh-client19a`.
  3.  Máquina *cliente 2*.
      - Con Windows, IP `172.18.19.11`, y hostname `ssh-client19b`.

  <hr>

* En la máquina *servidor*, nos dirigimos a `/etc/hosts`, modificamos el archivo introduciendo las 3 máquinas, con sus IPs y sus respectivos hostnames.

![imagen](./img/c1.PNG)

* Hacemos pequeñas comprobaciones con los siguientes comandos:
>ip a
>
>sudo route -n
>
>ping 172.18.19.32 (*Máquina cliente1*)
>
>ping ssh-client19a
>
>lsblk
>
>sudo blkid


![imagen](./img/c3.PNG)


![imagen](./img/c4.PNG)


![imagen](./img/c5.PNG)


![imagen](./img/c6.PNG)


![imagen](./img/c7.PNG)


![imagen](./img/c8.PNG)


![imagen](./img/c9.PNG)

<hr>

* Creamos usuarios *(en la máquina servidor)*, con los cuales nos conectaremos remotamente via ssh.
  * Utilizar el comando `sudo useradd -m perez1`, y luego, `sudo passwd perez1` para asignarle contraseña.

![imagen](./img/c10.PNG)

* Vamos ahora a la **máquina cliente 1** para añadir en `etc/hosts` a la máquina servidor y cliente 2.

![imagen](./img/c11.PNG)

* Comprobamos que está bien haciendo un ping a la máquina servidor.

![imagen](./img/c12.PNG)

* Ahora en la máquina cliente 2, iremos a descargar el programa `putty`, con el que haremos la conexión remota.

![imagen](./img/c13.PNG)


![imagen](./img/c14.PNG)


![imagen](./img/c15.PNG)

* Y cambiamos su nombre de equipo, a su correspondiente, y su grupo de trabajo.

![imagen](./img/c16.PNG)

* Nos dirigimos a la ruta `C:\Windows\System32\drivers\etc\hosts` y ahí añadimos a la máquina servidor y cliente 1.

![imagen](./img/c17.PNG)

* Volvemos a comprobar con un *ping*.

![imagen](./img/c18.PNG)

![imagen](./img/c19.PNG)

<hr>

# Conexión

* Volvemos a la máquina servidor e instalamos openssh con el comando `sudo zypper install openssh`.
  * En mi caso ya está instalado.

![imagen](./img/c20.PNG)

* Comprobamos el *status* del servicio, y está inactivo.

![imagen](./img/c21.PNG)

* Entonces lo activamos.
  * `sudo systemctl start sshd`
    - Y volvemos a comprobar.

![imagen](./img/c22.PNG)

* Con `netstat -ntap` comprobamos que el servicio sshd escucha el puerto 22,

![imagen](./img/c23.PNG)

* Autorizamos a dicho servicio en el *cortafuegos*.

![imagen](./img/c24.PNG)

* Vemos que la máquina servidor está con el servicio ssh activa en el puerto 22, lo comprobamos desde la máquina cliente con el comando `nmap -Pn ssh-server19`.

![imagen](./img/c25.PNG)

* Instalamos el servicio ssh en el cliente también, y probamos la primera conexión **cliente-servidor**.
  * `ssh usuario@máquina`
    * `ssh perez11@ssh-server19`

![imagen](./img/c27.PNG)

* Con un `ll .ssh/` comprobamos que se ha creado un nuevo documento, el cual contiene una contraseña de acceso.

![imagen](./img/c28.PNG)

![imagen](./img/c29.PNG)

![imagen](./img/c30.PNG)

* Comprobamos ahora desde Windows.
  * Introducimos el nombre del servidor.

![imagen](./img/c33.PNG)

* Nos da el *key fingerprint* y pulsamos *Sí*.


![imagen](./img/c31.PNG)

* Introducimos el usuario, y luego, su contraseña.
  * Y ya estamos dentro del servidor.

![imagen](./img/c32.PNG)

<hr>

# Cambiamos las claves del servidor.

* En el *servidor* comprobamos que tenemos creadas varias contraseñas de ssh, tanto públicas como privadas.

![imagen](./img/c34.PNG)

* Modificamos el archivo `/etc/ssh/sshd_config` y descomentamos la línea `HostKey /etc/ssh/ssh_host_rsa_key`.

![imagen](./img/c35.PNG)

* Una vez hecho esto, generamos una *ssh-keygen* rsa.
  * `sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key`

![imagen](./img/c36.PNG)

* Reiniciamos el servicio sshd.

![imagen](./img/c37.PNG)

* Comprobamos que el servicio sigue activo sin ningún problema.

![imagen](./img/c38.PNG)

* Y ahora intentamos volver a conectarnos cliente>servidor.
  * Y como comprobamos, es imposible conectarnos, ya que hemos cambiado la *rsa key*.

![imagen](./img/c39.PNG)

<hr>

# Personalizar el prompt Bash y alias.

* En el servidor, nos dirigimos a `/home/perez11/.alias`
  * Introducimos los alias que queremos probar, en mi caso tenemos uno para el *Clear, Geany, Ping, vdir -cF1 y ssh*.

![imagen](./img/c40.PNG)

* Personalizamos nuestro **prompt** con un *script* que nos quedaría de la siguiente forma.

![imagen](./img/c41.PNG)

* Y ahora podemos comprobar que ha cambiado el prompt, si no ha cambiado, utilizamos un `source .bashrc` y luego comprobamos también los alias.

![imagen](./img/c42.PNG)

<hr>

# Claves públicas.

* Iniciamos sesión con el usuario normal en el cliente.

![imagen](./img/c43.PNG)

* Generamos una *rsa key*.

![imagen](./img/c44.PNG)

* Y copiamos dicha key hacia el servidor.
  * `ssh-copy-id perez44@ssh-server19`

![imagen](./img/c45.PNG)

* Y ahora si entramos al usuario via ssh podemos *ver* que no nos pide ya la **contraseña** para entrar.

![imagen](./img/c46.PNG)

* Pero de hecho, desde el cliente de Windows sí, porque la clave la generamos desde el cliente A.

![imagen](./img/c47.PNG)

<hr>

# SSH tunel para X

* Instalamos el **geany** en la máquina servidor.

![imagen](./img/c48.PNG)

* `/etc/ssh/sshd_config`
![](assets/README-ec7ce8a9.jpg)
![imagen](./img/c49.PNG)


![imagen](./img/c50.PNG)


![imagen](./img/c51.PNG)


![imagen](./img/c52.PNG)


![imagen](./img/c53.PNG)


![imagen](./img/c54.PNG)


![imagen](./img/c55.PNG)

![imagen](./img/c56.PNG)

![imagen](./img/c57.PNG)


![imagen](./img/c58.PNG)


![imagen](./img/c59.PNG)


![imagen](./img/c60.PNG)


![imagen](./img/c61.PNG)


![imagen](./img/c62.PNG)


![imagen](./img/c63.PNG)


![imagen](./img/c63.PNG)

![imagen](./img/c64.PNG)
