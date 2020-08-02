#!/bin/bash
clear -x

echo -e "Sistema de administracion de usuarios y grupos \n¿Qué desea hacer?"

#MENU IMPRIMIR
datos (){
    echo -e "1) Crear_Grupo\n2) Crear_Usuario\n3) Salir"
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
        echo "Usuario $nameuser creado\nVolviendo al menu anterior"
        Opcion_Usuario
    fi
}
#CREAR GRUPO PERSONALIZADO
Crear_Usuario2 (){
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
