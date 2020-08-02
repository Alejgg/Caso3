#!/bin/bash
clear -x

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
#OPCION GRUPO
Opcion_Grupo (){
    echo -e "Ha seleccionado el añadir un nuevo grupo"
    menu="Grupo_Predeterminado Grupo_Personalizado Atras"
    select menu in $menu
    do
        if [ $menu = "Grupo_Predeterminado" ]; then
            echo "Creando grupo predeterminado"
            Crear_Grupo1
            elif [ $menu = "Grupo_Personalizado" ]; then
            echo "Creando grupo con id personalizado"
            Crear_Grupo2
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
Usuario (){
    while [ "$opcion" != 0 ]
    do
        
        echo  "MENU"
        echo "----------"
        echo "1) Crear un usuario con Directorio Home, Shell, Comentario, UID y GUI"
        echo "2) Crear un usuario sin Directorio Home, sin Shell, sin Grupo y un Comentario"
        echo "0) Salir"
        echo "----------"
        
        read opcion
        
        case $opcion in
            1)
                echo "Crear un usuario con Directorio Home, Shell, Comentario, UID y GUI"
                echo "El usuario actual es $nameuser"
                echo "insertar el Directorio Home:"
                read home
                echo "insertar el shell:"
                read shell
                echo "insertar comentario: "
                read comentario
                echo "insertar el user ID: "
                read UID
                echo "insertar el group ID: "
                read GID
                echo "El usuario a crear quedaria de la siguiente manera:"
                echo "$nameuser:x:$UID:$GID:$comentario:$home:$shell:"
                echo "Desea continuar Y/n?"
                read respuesta
                if [[ $respuesta = Y || $respuesta = y ]]; then
                    echo "Creando usuario"
                    useradd -m -d $home -s $shell -c "$comentario" -u $UID -g $GID $nameuser
                    elif [[ $respuesta = n || $respuesta = N ]]; then
                    echo -e "Usuario no creado"
                fi
                
            ;;
            
            2)
                echo "Crear un usuario sin Directorio Home, sin Shell, sin Grupo y un Comentario"
                echo "insertar el usuario actual es $nameuser "
                echo "insertar comentario: "
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
    menu="Crear_Grupo Crear_Usuario Salir"
    select menu in $menu
    do
        if [ $menu = "Crear_Grupo" ]; then
            Opcion_Grupo
            elif [ $menu = "Crear_Usuario" ]; then
            Opcion_Usuario
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
