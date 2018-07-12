SETUP & CONNECTIVITY
====================

```
+---------------+	    +------------+	      +------------+	        +---------------+
|  Contrail     |   BGP     | SDN GW     |	      | SDN GW     |    BGP	| Contrail	|
|  Controller   |-----------| vMX        |------------|  vMX       |----------- | Controller    |         	
+---------------+           +------------+ STATIC     +------------+            +---------------+
	|                        |	   ROUTE		|			|
	| XMPP			 |	     			|		 	| XMPP
	|			 |				|			| 
+----------------+		 |	         		| 		+------------------+		   
| vRouter Agent	 |---------------+				+---------------| vRouter Agent	   |
| Compute Node   | MPLS Over GRE				MPLS Over GRE	| Compute Node	   |
+----------------+								+------------------+

```


 Service Instance Use cases
 ==========================
 
 ```
 
					Service Instance I
		 		     ++===================++		    +------------------------+
		+-----------+	     ||	+-------------+   ||		    |			     |
		| Client    |	Left ||	|  vSRX	      |	  || 	Right       |	Application	     |
		| SFTP	    |--------|| | 	      |	  ||--------------- |	Servers		     |
		| HTTP/DNS  |	     ||	+-------------+	  ||		    |   		     | 
		+-----------+	     ||	ECMP/NAT	  ||		    |	DNS / HTTP / SFTP    |
		  |	|	     ||	+-------------+	  ||		    |	Servers		     |
		  |	|	     ||	| vSRX	      |	  ||		    |			     |
		  |	+------------||-|	      |	  ||		    |	           	     |
		  |		     ||	+-------------+	  ||		    +------------------------+
		  |      	     ++===================++			      |
		  |	Left		+---------------+			Right |
		  +---------------------| Load Balancer |-----------------------------+
					|	        |
					+---------------+
				       Service Instance II
		
```

1) Service Templates 
	- Network Type (In NetworK, In Network with NAT, Transparent)
	- Management 
	- Left 
	- right 
	- Availablity Zone
	- Select the image/ Loadbalancer image
	
2) Service Instances
	- Select the service template
	- Number of instances (Active - Active, Active-Standby or None)
	- Configure the interfaces (Management, Left and Right with UP / Auto Configured) 	

3) Service Policy
	- Create Policy - Service chain policy = PASS ANY 172.16.90.0/24 DEST

