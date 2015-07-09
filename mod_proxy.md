1. /usr/sbin/getsebool -a |grep httpd_can_network_connect <br/>


2. 我们需要将httpd_can_network_connect设置为on： <br/>
    /usr/sbin/setsebool -P httpd_can_network_connect=1   <br/>
    /usr/sbin/getsebool -a |grep httpd_can_network_connect   <br/>

httpd_can_network_connect --> on  <br/>

===
```bash
ProxyPass  /wordpress balancer://balancername
ProxyPassReverse /wordpress balancer://balancername

<Proxy balancer://balancername>
        BalancerMember  http://earthshaker.cn/wordpress loadfactor=1 
        BalancerMember  http://wenha1oli.cn/wordpress loadfactor=1  status=+H 
</Proxy>
```
