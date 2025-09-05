
## Delete and deploy

```sh
oc delete deploy/openldap pvc/openldap-pvc ; oc apply -f openldap-deploy.yaml -f openldap-pvc.yaml; oc logs deploy/openldap  -f
```

## Log for after deleting:

```sh
$ oc logs deploy/openldap -f
 11:43:08.21 INFO  ==> ** Starting LDAP setup **
 11:43:08.29 INFO  ==> Validating settings in LDAP_* env vars
 11:43:08.29 INFO  ==> Initializing OpenLDAP...
 11:43:08.36 INFO  ==> Creating LDAP online configuration
 11:43:08.37 INFO  ==> Creating slapd.ldif
 11:43:08.39 INFO  ==> Starting OpenLDAP server in background
 11:43:09.40 INFO  ==> Configure LDAP credentials for admin user
 11:43:09.41 INFO  ==> Adding LDAP extra schemas
 11:43:09.43 INFO  ==> Loading custom LDIF files...
 11:43:09.44 WARN  ==> Ignoring LDAP_USERS, LDAP_PASSWORDS, LDAP_USER_OU, LDAP_GROUP_OU and LDAP_GROUP environment variables...
```

And then:

```sh
$ oc logs deploy/openldap -f
 11:43:10.81 INFO  ==> ** Starting LDAP setup **
 11:43:10.88 INFO  ==> Validating settings in LDAP_* env vars
 11:43:10.89 INFO  ==> Initializing OpenLDAP...
 11:43:10.96 INFO  ==> Using persisted data
 11:43:10.96 INFO  ==> ** LDAP setup finished! **

 11:43:11.00 INFO  ==> ** Starting slapd **
68bacccf.03b3a161 0x7f0b4eadb740 @(#) $OpenLDAP: slapd 2.6.10 (May 23 2025 04:19:14) $
	@79176fda6d74:/bitnami/blacksmith-sandox/openldap-2.6.10/servers/slapd
68bacccf.043a7f9a 0x7f0b4eadb740 slapd starting
```

## Make a search

```sh
oc rsh deploy/openldap ldapsearch -x -H ldap://localhost:1389 -b dc=example,dc=org -D cn=admin,dc=example,dc=org -o ldif-wrap=no -w adminpassword '(cn=*)'
```

