# Servidor de impresión en Windows.

---

* Utilizaremos una máquina servidor y una máquina cliente.
  * Máquina servidor: Windows Server 2012.
  * Máquina cliente: Windows 10.

---

## Rol de impresión.

* Vamos a instalar en el servidor el rol de impresión.
  * `Asistente para agregar roles y características` -> `Servicios de impresión y documentos`.

![img](./img/000081.png)

* En servicios de rol elegimos los siguiente:
  * `Servidor de Impresión` + `Impresión en Internet`

![img](./img/000083.png)

* Y procedemos a la instalación.
  * Seleccionamos la casilla de *Reiniciar automáticamente* por si es necesario.

![img](./img/000084.png)

---

## Instalar impresora PDF.

* Vamos a instalar PDF Creator.
  * Para ello vamos a la página web oficial de *PDF Creator* y buscamos el apartado **Descarga**.
  * Descargamos, y ejecutamos el *setup*.

![img](./img/000078.png)

* Si es necesario, habrá que instalar también el `Microsoft Visual C++ 2015`.

![img](./img/000079.png)


![img](./img/000080.png)

---

## Probar impresora en local.

* Seleccionamos cualquier *txt* (por ejemplo) que queramos imprimir, le damos *Click derecho -> Imprimir* y elegimos la opción `Impresora PDF`.

![img](./img/000085.png)

* Le damos un nuevo nombre (si queremos) al archivo, y ya lo tendríamos en `.pdf` y listo.

![img](./img/000086.png)

![img](./img/000087.png)

---

## Compartir por red.

* Vamos a nuestro servicio de impresión.
  * *Administración de servidor* -> *Panel* -> *Administración de impresión* -> *PDF Pro Virtual Printer*

![img](./img/000088.png)

* *Click derecho* -> *Propiedades* -> *Compartir*
  * Le ponemos el nombre que queramos.

![img](./img/000089.png)

* Nos movemos al cliente, entramos en **red** y seleccionamos nuestra impresora. Para entrar nos pedirá las credenciales de Windows Server.

![img](./img/000090.png)

![img](./img/000091.png)

![img](./img/000092.png)

* Probamos a imprimir un archivo en el cliente, y luego comprobar en el servidor.

![img](./img/000093.png)

* Cuando vamos al servidor, en la carpeta **Documentos** tendría que estar el PDF.

![img](./img/000094.png)

---

## Acceso Web


>   Vamos al servidor.
    Nos aseguramos de tener instalado el servicio "Impresión de Internet".

* En la máquina cliente, abrimos un navegador y en la barra de navegación escribimos: `http://<nombre-del-servidor>/printers`

![img](./img/000095.png)

* Configuramos ahora la posibilidad de imprimir desde la red en esa impresora compartida utilizando la URL conocida.
  * Y comprobamos desde el propio navegador que podemos pausar, reanudar, y envíar archivos a la impresora.

![img](./img/000096.png)

---
