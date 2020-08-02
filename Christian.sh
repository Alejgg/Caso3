#!/bin/sh
clear 
while [ "$opcion" != 0 ]

do

 
 echo "----------"
 echo "1.- Inicio"
 echo "0.- Salir"
 echo "----------"

 read opcion

 case $opcion in
 1)
  clear
  echo "Ingrese nombre del grupo"
  read group

 	if grep -q $group /etc/group
    then
	clear
         echo "El grupo existe"
							echo "Ingrese el usuario a agregar en este grupo"
				read user
				if grep -q $user /etc/passwd
   				 then
   				      echo "El usuario existe"
					useradd -m -g $group $user
					echo "Y se agrego a el grupo anteriormente creado"
   				 else
     				    echo "Creando usuario"
						adduser $user
						useradd -m -g $group $user
						echo "tambien se agrego a el grupo anteriormente creado"
   						echo "-----------------------------"
						echo "archivo de verificacion grupo"
   						 getent group $group
						echo "-----------------------------"
						echo "archivo de verificacion usuario"
						getent passwd $user
						echo "-----------------------------"
						mkdir -p /usuarios/$user
						chgrp $group /usuarios/$user
						chown $user /usuarios/$user	
							chmod 774 /usuarios/$user
				fi




    else
	  clear
         echo "El grupo no existe"
	
	  groupadd $group
				echo "grupo agregado"
				echo "Ingrese el usuario a agregar en este grupo"
				read user
				if grep -q $user /etc/passwd
   				 then
   				      echo "El usuario existe"
					useradd -m -g $group $user
					echo "Y se agrego a el grupo anteriormente creado"
   				 else
     				    echo "Creando usuario"
						adduser $user
						useradd -m -g $group $user
						echo "tambien se agrego a el grupo anteriormente creado"
						echo "-----------------------------"
						echo "archivo de verificacion grupo"
   						 getent group $group
						echo "-----------------------------"
						echo "archivo de verificacion usuario"
						getent passwd $user
						echo "-----------------------------"
						mkdir -p /usuarios/$user
						chgrp $group /usuarios/$user
						chown $user /usuarios/$user	
							chmod 774 /usuarios/$user	
						
				fi
    fi

  ;;


  esac
 done
exit 0
