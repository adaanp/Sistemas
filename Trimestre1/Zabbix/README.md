## Zabbix

1. [Sysload](#id1)
2. [Raids](#id2)

## Sysloads <a name="id1"></a>

* To check the load with the system we can use the command `cat /proc/loadavg`.

The result is that -> [img](./img/000362.png)

As we can see, there are 5 values.
The first three columns measure CPU and IO utilization of the last one, five, and 10 minute periods. The fourth column shows the number of currently running processes and the total number of processes. The last column displays the last process ID used.

* We want the first three columns, so we can take this values with `cat /proc/loadavg | cut -f 1-3 -d " "`

Our objective is to print this values on a graphic, and we have three numbers, so a graphic can't screen that.
A simple way to screen it, is to divide one per one.

Making scripts for each value, we can take it easy.
Three scripts like these:

* [img](./img/000363.png)

* [img](./img/000364.png)

* [img](./img/000365.png)

The next step is to add these values or *keys* to `zabbix_agentd.conf`, on **UserParameters**.
[img](./img/000366.png)

* So now, we can add the new items on Zabbix.

Just go to **Configuration** -> **Hosts**, then pick the host/server Items, and go to **Create Item**.

We should fill like this image, where the name is whatever you want, and the key is the ID you put on *UserParameters*.
The rest of fields you should fill as you wants to configure.

[img](./img/000367.png)

Remember that we need to create 3 items, because we have 3 values on different scripts, so we repeat the same process but with another ID.

The last step is to create the graph. Click on **Graphs** [img](./img/000368.png) and then **Create Graph**.

You configure your graph as you want, but add the 3 items we have created before, like that:
[img](./img/000369.png)

* Then you go to the *Main Menu* of Zabbix, and on *Graphs* you can check your own graph.

[img](./img/000370.png)

## Raids <a name="id2"></a>
