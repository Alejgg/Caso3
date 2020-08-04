#!/bin/bash
datos (){
    echo -e "1) Crear_Grupo\n2) Crear_Usuario\n3) Listar_Usuarios\n4) Listar_Grupos\n5) Salir"
    
}
#CREAR GRUPO PREDETERMINADO
Crear_Grupo1 (){
    echo "Digite el nombre del grupo a crear"
    read namegroup
    if grep -q $namegroup /etc/group
    then
        echo -e "El grupo $namegroup ya existe \nVolviendo al menu anterior"
        Opcion_Grupo
    else
        addgroup $namegroup
        echo -e "Se ha creado un grupo con el nombre de $namegroup\nVolviendo al menu anterior"
        Opcion_Grupo
    fi
}
#CREAR GRUPO PERSONALIZADO
Crear_Grupo2 (){
    echo "Digite el nombre del grupo a crear"
    read namegroup
    echo "Digite el ID del grupo"
    read ID
    if grep -q $namegroup /etc/group
    then
        echo -e "El grupo $namegroup ya existe \nVolviendo al menu anterior"
        Opcion_Grupo
    else
        echo "Desea introducir una contrasena y/n?"
        read respuesta
        if [[ $respuesta = Y || $respuesta = y ]]; then
            echo "Contrasena:"
            read pass
            groupadd -g $ID -p "$pass" $namegroup
            echo -e "Se ha creado un grupo con el nombre de $namegroup con el ID $ID y contrasena $pass\nVolviendo al menu anterior"
            Opcion_Grupo
            elif [[ $respuesta = n || $respuesta = N ]]; then
            groupadd -g $ID $namegroup
            echo -e "Se ha creado un grupo con el nombre de $namegroup e ID $ID\nVolviendo al menu anterior"
            Opcion_Grupo
        fi
        
    fi
}
#ANADIR GRUPO
Anadir_Grupo (){
    clear -x
    echo "Lista de grupos existentes:"
    cat /etc/group | cut -d: -f1,3 | nl
    echo "Ingrese nombre o id del grupo"
    read group
    echo "Ingrese el usuario a agregar en este grupo"
    read user
    usermod -a -G $group $user
    echo "Usuario $user agregado al grupo $group"
    
}
#OPCION GRUPO
Opcion_Grupo (){
    echo -e "Ha seleccionado el añadir un nuevo grupo"
    menu="Grupo_Predeterminado Grupo_Personalizado Anadir_Usuario_a_un_Grupo Atras"
    select menu in $menu
    do
        if [ $menu = "Grupo_Predeterminado" ]; then
            echo "Creando grupo predeterminado"
            Crear_Grupo1
            elif [ $menu = "Grupo_Personalizado" ]; then
            echo "Creando grupo con id personalizado"
            Crear_Grupo2
            elif [ $menu = "Anadir_Usuario_a_un_Grupo" ]; then
            Anadir_Grupo
            elif [ $menu = "Atras" ]; then
            echo "Menu anterior"
            menu
        else
            echo "Opcion no valida"
        fi
        
    done
}

#CREAR GRUPO PREDETERMINADO
Crear_Usuario1 (){
    echo "Digite el nombre del usuario a crear"
    read nameuser
    if grep -q $nameuser /etc/passwd
    then
        echo -e "El usuario $nameuser ya existe\nVolviendo al menu anterior"
        Opcion_Usuario
    else
        adduser $nameuser
        echo -e "Usuario $nameuser creado\nVolviendo al menu anterior"
        Opcion_Usuario
    fi
}
caso1 (){
    echo "Creando Directorio Home, Shell, Comentario, UID y GUI"
    echo "El usuario a crear es $nameuser"
    echo "Insertar el Directorio Home:"
    read home
    echo "Insertar el shell:"
    read shell
    echo "Insertar comentario: "
    read comentario
    echo "Insertar el user ID: "
    read uID
    while grep -q $uID /etc/passwd
    do
        echo "ID de usuario repetido!! prueba con otro: "
        read uID
    done
    echo "Desea crear un grupo con el mismo nombre del usuario $nameuser Y/n?"
    read respuesta
    if [[ $respuesta = Y || $respuesta = y ]]; then
        grupo2=$nameuser
        while grep -q $grupo2 /etc/group
        do
            echo "Un grupo con el nombre $nameuser ya existe!! prueba con otro: "
            read grupo2
        done
        echo "Creando grupo $grupo2"
        groupadd $grupo2
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo -e "Grupo no creado"
    fi
    echo "Lista ultimos 10 grupos existentes"
    tail /etc/group | cut -d: -f1,3
    echo "Insertar el group ID: "
    read GID
    echo "El usuario a crear quedaria de la siguiente manera:"
    echo "$nameuser:x:$uID:$GID:$comentario:$home:$shell:"
    echo "Desea continuar Y/n?"
    read respuesta
    if [[ $respuesta = Y || $respuesta = y ]]; then
        echo "Creando usuario"
        useradd -m -d $home -s $shell -c "$comentario" -u $uID -g $GID $nameuser
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo -e "Usuario no creado"
        Usuario
    fi
    echo "Desea poner una contrasena al usuario $nameuser creado Y/n?"
    read respuesta
    if [[ $respuesta = Y || $respuesta = y ]]; then
        passwd $nameuser
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo -e "Usuario $nameuser sin contrasena"
    fi
}
Usuario (){
    clear -x
    while [ "$opcion" != 0 ]
    do
        
        echo  "MENU"
        echo "----------"
        echo "1) Crear Directorio Home, Shell, Comentario, UID y GUI para $nameuser"
        echo "2) No Crear Directorio Home, sin Shell, sin Grupo y un Comentario para $nameuser"
        echo "0) Salir"
        echo "----------"
        
        read opcion
        
        case $opcion in
            1)
                caso1
            ;;
            
            2)
                echo "Crear un usuario sin Directorio Home, sin Shell, sin Grupo y un Comentario"
                echo "El usuario actual es $nameuser "
                echo "Insertar comentario: "
                read comentario
                useradd -M -N -r -s /bin/false -c "$comentario" $nameuser
            ;;
        esac
    done
}

#CREAR USUARIO PERSONALIZADO
Crear_Usuario2 (){
    echo "Digite el nombre del usuario a crear"
    read nameuser
    if grep -q $nameuser /etc/passwd
    then
        echo -e "El usuario $nameuser ya existe\nVolviendo al menu anterior"
        Opcion_Usuario
    else
        Usuario
        Opcion_Usuario
    fi
}
#OPCION USUARIO
Opcion_Usuario (){
    echo -e "Ha seleccionado el añadir un nuevo usuario"
    menu="Usuario_Predeterminado Usuario_Personalizado Atras"
    select menu in $menu
    do
        if [ $menu = "Usuario_Predeterminado" ]; then
            echo "Creando usuario predeterminado"
            Crear_Usuario1
            elif [ $menu = "Usuario_Personalizado" ]; then
            echo "Creando usuario con personalizado"
            Crear_Usuario2
            elif [ $menu = "Atras" ]; then
            echo "Menu anterior"
            menu
        else
            echo "Opcion no valida"
        fi
        
    done
}

#MENU PRINCIPAL
menu (){
    echo -e "Sistema de administracion de usuarios y grupos \n¿Qué desea hacer?"
    menu="Crear_Grupo Crear_Usuario Listar_Usuarios Listar_Grupos Salir"
    select menu in $menu
    do
        if [ $menu = "Crear_Grupo" ]; then
            Opcion_Grupo
            elif [ $menu = "Crear_Usuario" ]; then
            Opcion_Usuario
            elif [ $menu = "Listar_Usuarios" ]; then
            cat /etc/passwd | cut -d: -f1,3,5 | nl
            menu
            elif [ $menu = "Listar_Grupos" ]; then
            cat /etc/group | cut -d: -f1,3,4 | nl
            menu
            elif [ $menu = "Salir" ]; then
            echo "Fin de la sesion"
            exit
        else
            echo "Opcion no valida"
            datos
        fi
        
    done
}

menu
