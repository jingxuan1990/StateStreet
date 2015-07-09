1. /usr/sbin/getsebool -a |grep httpd_can_network_connect 
2. 我们需要将httpd_can_network_connect设置为on：
    /usr/sbin/setsebool -P httpd_can_network_connect=1 
    /usr/sbin/getsebool -a |grep httpd_can_network_connect 

httpd_can_network_connect --> on  

===

ProxyPass  /wordpress balancer://balancername
ProxyPassReverse /wordpress balancer://balancername

<Proxy balancer://balancername>
        BalancerMember  http://earthshaker.cn/wordpress loadfactor=1
        BalancerMember  http://wenha1oli.cn/wordpress loadfactor=1  status=+H
</Proxy>
