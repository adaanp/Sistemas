# Windows Server 2016 - Failover clustering for HyperV

Considering that we have the DNS server and Active Directory installed:

* The first thing will be create an iSCSI virtual disk.
  * The name of the virtual disk is going to be k00v.disk on the k00v machine, and k01v.disk on the k01v machine.
  * 10 GB on each disk with fixed size.

* Next step is to add targets on the **iSCSI Initiator** on the *discovery portal*, where we will put the k00v and k01v IPs.

* Then, on Disk Management we will bring online the disks created and make new simple volume.

* **IMPORTANT**: We will do this steps on both machines.

* On *Add roles and features* we should install HyperV role and Failover Clustering feature (in our case, the HyperV packets are already installed because we are using the remote desktop app).  

* Now, on the HyperV manager we should check that our virtual switch is configured with a **Name**, a **External Network** connection type and the option **Allow management operating system to share this network adapter** checked. This configuration has to be the same on both machines.

* At this point, we are now ready to validate our systems on the **Failover Cluster Mananger**. We run all the possible tests and during the validation process, the iSCSI disk will go down several times.  

* Once the validation is finished, we get only one warning, that is about the lack of a second network adapter.

* We create the cluster by just checking the  **Create the cluster now using the validated nodes...** option. After this, we have to set the name and the IP were the cluster will be located.

* And now is were the problems start. Our iSCSI disk disapear from both machines without any reason. We have check every log on the event viewer but we only see problems about the DNS server. This is weird due to the fact that we can ping the machines and the cluster with their respectives names on the console.  

At this point, we couldnt do more because we didnt know what was happening with our servers. We did reinstall everything from the scracth but the outcome was still the same.

Our work was done thanks to the following videos:  
 *  https://www.youtube.com/watch?v=TQNtiAThe9M&t=6s
 *  https://www.youtube.com/watch?v=fIoPywVWT2I

The only difference between his project and ours is that he is using a third machine for the iSCI storage.
