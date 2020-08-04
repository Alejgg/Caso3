#!/bin/bash

usuario (){ #VERIFICAR NOMBRE DE USUARIO REPETIDO
    while grep -q $nameuser /etc/passwd
    do
        echo "Nombre de usuario repetido!! prueba con otro: "
        read nameuser
    done
}
uid (){ #VERIFICAR ID USUARIO REPETIDO
    while grep -q $uID /etc/passwd
    do
        echo "ID de usuario repetido!! prueba con otro: "
        read uID
    done
}

ans1 (){ #RESPUESTA CREAR GRUPO
    if [[ $respuesta = Y || $respuesta = y ]]; then
        grupo2=$nameuser
        while grep -q $grupo2 /etc/group #VERIFICAR EL NOMBRE DEL GRUPO NO SE REPITE
        do
            echo "Un grupo con el nombre $nameuser ya existe!! prueba con otro: "
            read grupo2
        done
        echo "Creando grupo $grupo2"
        groupadd $grupo2
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo -e "Grupo no creado"
    fi
}

ans2 (){ #RESPUESTA PARA CREAR USUARIO
    if [[ $respuesta = Y || $respuesta = y ]]; then
        echo "Creando usuario"
        useradd -m -d $home -s $shell -c "$comentario" -u $uID -g $GID $nameuser
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo -e "Usuario $nameuser no creado"
        exit 1
    fi
}

ans3 (){ #RESPUESTA PARA PONER CONTRASENA
    if [[ $respuesta = Y || $respuesta = y ]]; then
        passwd $nameuser
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo -e "Usuario $nameuser sin contrasena"
    fi
}

#TEXTO A MOSTRAR EN PANTALLA Y VARIABLES
echo -e "CREAR USUARIOS Y GRUPOS\nIntroduce el nombre del nuevo usuario:"
read nameuser
usuario
echo "Insertar el Directorio Home para $nameuser:"
read home
echo "Insertar la shell para $nameuser:"
read shell
echo "Insertar algun comentario para $nameuser: "
read comentario
echo "Insertar el ID del nuevo usuario $nameuser: "
read uID
uid
echo "Desea crear un grupo con el mismo nombre del usuario $nameuser Y/n?"
read respuesta
ans1
echo "Lista ultimos 10 grupos existentes"
tail /etc/group | cut -d: -f1,3
echo "Insertar el ID del grupo al que pertenecera $nameuser: "
read GID
echo "El usuario a crear quedaria de la siguiente manera:"
echo "$nameuser:x:$uID:$GID:$comentario:$home:$shell:"
echo "Desea continuar Y/n?"
read respuesta
ans2
echo "Desea poner una contrasena al usuario $nameuser creado Y/n?"
read respuesta
ans3