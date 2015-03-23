## Fetch Password From Cloakware

```java
package com.ssc.cloakware;

import java.security.Principal;
import java.security.acl.Group;
import java.util.Map;

import javax.management.MBeanServer;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;
import javax.resource.spi.ManagedConnectionFactory;
import javax.resource.spi.security.PasswordCredential;
import javax.security.auth.Subject;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.login.LoginException;

import org.jboss.logging.Logger;
import org.jboss.security.SimplePrincipal;
import org.jboss.security.util.MBeanServerLocator;
import org.picketbox.datasource.security.AbstractPasswordCredentialLoginModule;

import Matrix.PwMatrix;

/**
 * class is used to get password from cloakware
 *  
 * @author Andy Li
 * @Date 3/19/2015
 */

public class CloakwareLoginModule extends AbstractPasswordCredentialLoginModule
{
    /**
     * Class logger
     */
    private static final Logger log = Logger.getLogger(CloakwareLoginModule.class);

    private String password;
    private String username;
    private MBeanServer mbServer;
    private ObjectName managedConnectionFactoryName;
    private ManagedConnectionFactory mcf;
    /** A flag that allows a missing MCF service to be ignored */
    private Boolean ignoreMissigingMCF;

    public void initialize(Subject subject, CallbackHandler handler, Map sharedState, Map options)
    {
        
        log.debug("initialize method is invoked......");
        
        super.initialize(subject, handler, sharedState, options);
        
        String server = (String) options.get("server");
        String user   = (String) options.get("user");
        String name   = (String) options.get("managedConnectionFactoryName");
        
        log.debug("managedConnectionFactoryName is :" + name);
        
        try
        {
            managedConnectionFactoryName = new ObjectName(name);
        }
        catch (MalformedObjectNameException mone)
        {
           throw new IllegalArgumentException("Malformed ObjectName: " + name);
        }
        
        if (managedConnectionFactoryName == null)
        {
           throw new IllegalArgumentException("Must supply a managedConnectionFactoryName!");
        }
        
        Object flag = options.get("ignoreMissigingMCF");
        
        if( flag instanceof Boolean ){
            ignoreMissigingMCF = (Boolean) flag; 
        }else if( flag != null ){
            ignoreMissigingMCF = Boolean.valueOf(flag.toString()); 
        }
        
        mbServer = MBeanServerLocator.locateJBoss();
        
        getMcf();
        
       
        if(server == null || user== null)
        {
            throw new IllegalArgumentException("The server and user is a required option.");
        }
        
        try
        {
            username = user;
//            log.info("getting password from pw...");
            password = PwMatrix.getPassword(server, user);
//            log.info("pw password is :  " + password);
        }
        catch(Exception e)
        {
            e.printStackTrace();
            throw new IllegalArgumentException("Failed to retrieve credentials from cloakware server.", e);
        }
        
        log.debug("initialize methodn is over......");
    }
       
    @Override
    protected Principal getIdentity()
    {
//        log.info("getIdentity method start......");
        Principal principal = new SimplePrincipal(username);
//        log.info("pw principal name is: " + principal.getName());
//        log.info("pw principal object is: " + principal);
//        log.info("getIdentity method is over......");
        return principal;
    }

    @Override
    protected Group[] getRoleSets() throws LoginException
    {
//        log.info("getRoleSets method start......");
        Group[] empty = new Group[0];
//        log.info("getRoleSets method is over......");
        return empty;
    }
    
    public boolean login() throws LoginException
    {
        log.debug("login method start......");
        if (super.login())
            return true;

        super.loginOk = true;
        
       log.debug("pw login status is: " + this.loginOk);
       log.debug("login method is over......");
       
       return true;
    }

    public boolean commit() throws LoginException
    {
        log.debug("commit method start......");
        
        Principal principal = new SimplePrincipal(username);
        
//        log.debug("principal name is" + principal.getName());
        
        subject.getPrincipals().add(principal);
        
//        Set<Principal> sets  = subject.getPrincipals();
//        Iterator<Principal> iter = sets.iterator();
//        while(iter.hasNext()){
//           log.info("principal iter is " + iter.next().getName());
//        }
                
        sharedState.put("javax.security.auth.login.name", username);
        try
        {
            char[] password = this.password.toCharArray();
            
            log.debug("pw password(char[]) is " + String.valueOf(password));

            PasswordCredential cred = new PasswordCredential(username, password);
            cred.setManagedConnectionFactory(mcf);
            
//            log.info("pw cred username is " + cred.getUserName());
//            log.info("pw cred password is " + String.valueOf(cred.getPassword()));
            log.debug("pw cred ManagedConnectionFactory is " + cred.getManagedConnectionFactory());
            
           
            
            subject.getPrivateCredentials().add(cred);
            
//            log.info("private cred: " + subject.getPrivateCredentials());
//            log.info("public cred: " + subject.getPublicCredentials());
        }
        catch (Exception e)
        {
            throw new LoginException("Failed to login: " + e.getMessage());
        }
        
        log.debug("commit() method is over......");
        return true;
    }
    
    
    protected ManagedConnectionFactory getMcf()
    {
       if (mcf == null)
       {
          try
          {
             mcf = (ManagedConnectionFactory) mbServer.getAttribute(
                managedConnectionFactoryName,
                "ManagedConnectionFactory");
          }
          catch (Exception e)
          {
             log.error("The ConnectionManager mbean: " + managedConnectionFactoryName
                + " specified in a ConfiguredIdentityLoginModule could not be found."
                + " ConnectionFactory will be unusable!");
             if( Boolean.TRUE != ignoreMissigingMCF )
             {
                throw new IllegalArgumentException("Managed Connection Factory not found: "
                   + managedConnectionFactoryName);
             }
          } // end of try-catch
          if (log.isTraceEnabled())
          {
             log.trace("mcfname: " + managedConnectionFactoryName);
          }
       } // end of if ()

       return mcf;
    }

    protected MBeanServer getServer()
    {
       return mbServer;
    }
    
    
}

```
