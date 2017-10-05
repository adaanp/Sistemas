# **Acceso remoto VNC**

<hr>

# OpenSuse a OpenSuse

* Antes que nada, crearemos dos máquinas en VirtualBox, una **cliente** y otra **servidor** con *(por ejemplo)* 2048 GB de Ram, 15 GB de disco duro, la ISO de OpenSuse Leap, y adaptador puente.
  - Una vez instalada las máquinas, tenemos que configurar sus IPs.
  - La máquina **servidor** llevará la IP 172.18.19.31
  - La máquina **cliente** llevará la IP 172.18.19.32

![imagen](./img/OpenSuse/c1.PNG)

![imagen](./img/OpenSuse/c2.PNG)

* Una vez hecho, vamos, en ambas máquinas, a *Yast > Administración remota* y configuramos el sistema **VNC**.

![imagen](./img/OpenSuse/c3.PNG)

* Permitimos la administración remota.

![imagen](./img/OpenSuse/c4.PNG)

![imagen](./img/OpenSuse/c5.PNG)

* En el Firewall, autorizamos el VNC.
  - Todo esto hay que hacerlo en ambas máquinas.

![imagen](./img/OpenSuse/c6.PNG)

* Ahora solo en el **servidor** vamos a la terminal, y escribimos el comando *vncserver* e introducimos una contraseña de acceso.

![imagen](./img/OpenSuse/c7.PNG)

* Vamos al cliente, y escribimos *vncviewer* para entrar por control remoto, lo cual nos pedirá la IP del servidor, y al conectar, la contraseña anterior.

![imagen](./img/OpenSuse/c8.PNG)

* Y ya estaríamos dentro.

![imagen](./img/OpenSuse/c9.PNG)

* Con el comando *netstat -ntap* podemos comprobar que está la conexión establecida.

![imagen](./img/OpenSuse/c10.PNG)

<hr>

# Windows a Windows

* Configuramos las máquinas de Windows 10.
  - La máquina **servidor** tendrá la IP 172.18.19.11
  - La máquina **cliente** tendrá la IP 172.18.19.12


* Una vez listo, vamos a la página de **tightvnc**, donde descargaremos el servidor y cliente *vnc*.

![imagen](./img/Windows/c2.PNG)

* Y lo instalamos.
  - En la máquina servidor, hacemos *CUSTOM INSTALL* y sólo instalamos el vnc server
  - En la máquina cliente, instalamos sólo el vnc viewer.

![imagen](./img/Windows/c3.PNG)

* Abrimos el VNCServer y ponemos una contraseña de control para los clientes.

![imagen](./img/Windows/c1.PNG)

* Luego en *control acces** ponemos la IP del cliente.

![imagen](./img/Windows/c5.PNG)

* Volvemos a poner una contraseña de acceso para el cliente.

![imagen](./img/Windows/c6.PNG)

* Ahora, en la máquina **cliente**, abrimos el viewer, y hacemos conexión remota a la IP del servidor, ponemos la contraseña, y conectamos.

![imagen](./img/Windows/c7.PNG)

* Y ya deberíamos estar dentro, con lo que estamos en el escritorio del servidor.

![imagen](./img/Windows/c8.PNG)

* Como comprobación, utilizamos en la cmd el comando *netstat -n* y vemos que se ha establecido una conexión.

![imagen](./img/Windows/c9.PNG)

<hr>

# Windows a OpenSuse

* Con la máquina **servidor de OpenSuse y cliente de Windows**, haremos el mismo trabajo.

* Pasamos a abrir el programa VNC Viewer en Windows, e introducimos la IP de la máquina OpenSuse servidor.

![imagen](./img/OpenSuse/c11.PNG)

* Y ya entraríamos.

![imagen](./img/OpenSuse/c12.PNG)

<hr>

# OpenSuse a Windows

* En la máquina **cliente de OpenSuse** utilizamos el comando *vncviewer*, y cuando nos pida una IP, ponemos la de la máquina **servidor de Windows**

![imagen](./img/OpenSuse/c14.PNG)

* Con este paso entramos directamente.

![imagen](./img/OpenSuse/c13.PNG)

<hr>
