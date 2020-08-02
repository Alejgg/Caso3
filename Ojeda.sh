 #!/bin/bash
clear

echo "Bienvenido al sistema de administracion de usuarios y grupos ¿Qué desea hacer?"
opciones="Grupo Usuario Salir"

select opcion in $opciones

do
        if [ $opcion = "Grupo" ]; then
                echo  "Ha seleccionado el añadir un nuevo grupo"
                echo "Digite el nombre del grupo a crear"
                read namegroup

                if grep -q $namegroup /etc/group
                then
                        echo "El nombre del grupo ya existe"
                else
                        addgroup $namegroup
                echo "Se ha creado un grupo con el nombre de $namegroup"
                fi

        elif [ $opcion = "Usuario" ]; then
                echo "Bienvenido al sistema de usuarios"
                echo "Digite el nombre del usuario a crear"
                read  nameuser
                        if grep -q $nameuser /etc/passwd
                        then
                                echo "El nombre de usuario ya existe"
                        else
                                adduser $nameuser
                                echo "Se creo un nuevo usuario con el nombre de $nameuser"
                                mkdir -p /usuarios/$nameuser
                                chgrp $namegroup /usuarios/$nameuser
                                chown $nameuser/usuarios/$nameuser
                                chmod 774/usuarios/$user
                                echo "Se creó una nueva carpeta con el nombre de $nameuser"
        fi
        echo "Desea agregar el usuario a un grupo de trabajo?"


                agregar="Si no crear"
select  opc in $agregar;
                do
                if [ $opc = "Si" ]; then
                        cat /etc/group
                        echo "Asigne el nombre del grupo "
                        read $namegroup
                        $nameuser addgroup $namegroup
                        echo "El usuario $nameuser se asignó al grupo $namegroup"
                elif [ $opc = "no" ]; then
                        echo  "Adiós"
                        exit
                elif [ $opc = "crear" ]; then
                        echo "asigne el nombre del nuevo grupo"
                        read namegroup
                        addgroup $namegroup
                        $nameuser addgroup $namegroup
                        echo "Se creo un grupo con el nombre $namegroup y se le asignó el usuario $nameuser"
                else
                        echo "Esa opcion no es válida"
                fi
                done
        elif [ $opcion = "Salir" ]; then
                clear
                echo "Adiós"
                exit
        else
                echo "Ese opcion no esta disponible"
                exit
        fi

done
