#!/bin/bash
#Por: Alej_gg

#INICIO
echo -e "\e[34mSISTEMA PARA GUARDAR ARCHIVOS \e[0m"

function Verificar {
    echo "Introduce la ruta de la carpeta con los archivos a guardar: "
    read carpeta
    if [ -d "$carpeta" ]; then
        echo -e "Se ingreso la direccion: \e[1;34m $carpeta \e[0m la cual contiene:"
        ls -l  --color=auto --group-directories-first $carpeta
    else
        echo "El valor ingresado no es un directorio"
        exit
    fi
}

function Guardado {
    echo "Nombre del respaldo:"
    read name
    echo "Introduce la direccion para guardar el archivo:"
    read dir
    echo -e "La ruta a utilizar para guardar el archivo sera: \e[;34m $dir \e[0m"
}

function Archivar {
    Verificar
    Guardado
    tar -cvf "$dir/$name.tar" $carpeta
    echo -e "\e[1;42m Respaldo Efectuado con exito en $dir/$name.tar \e[0m"
}

function Archivar2 {
    Verificar
    Guardado
    echo "Introduce la extension de los archivos a guardar sin el . :"
    read extension
    tar -cvf "$dir/$name.tar" $carpeta/*.$extension
    echo -e "\e[1;42m Respaldo Efectuado con exito en $dir/$name.tar \e[0m"
}

function Listar {
    echo -e "Introduce la ruta del archivo con extension \e[1;31m .tar \e[0m para listar el contenido:"
    read archivo
    tar="tar -tf $archivo"
    echo -e "Los archivos dentro de \e[1;31m$archivo\e[0m son: \n "
    echo -e "\e[0;32m`$tar`\e[0m" | nl
}

function Extraer {
    echo -e "Introduce la ruta del archivo con extension \e[1;31m .tar \e[0m para extraer el contenido:"
    read archivo
    echo "Deseas extraer en la carpeta actual y/n?"
    read respuesta
    if [[ $respuesta = Y || $respuesta = y ]]; then
        echo "Extrayendo en la carpeta actual"
        tar -xvf $archivo
        elif [[ $respuesta = n || $respuesta = N ]]; then
        echo "Donde deseas extraer el contenido?"
        read extraer
        tar -xvf $archivo -C $extraer
    fi
    echo -e "\e[0;32mContenido extraido\e[0m"
}

#Accion
echo "Selecciona que deseas guardar:"
menu="Todo Archivos_Especificos Listar Extraer Salir"
select menu in $menu
do
    if [ $menu = "Todo" ]; then
        Archivar
        elif [ $menu = "Archivos_Especificos" ]; then
        Archivar2
        elif [ $menu = "Listar" ]; then
        Listar
        elif [ $menu = "Extraer" ]; then
        Extraer
        elif [ $menu = "Salir" ]; then
        echo -e "\e[1;35m Hasta la proxima \e[0m"
        exit
    else
        echo "Opcion no valida"
    fi
    echo -e "\n 1) Todo \n 2) Archivos_Especificos \n 3) Lista \n 4) Extraer \n 5) Salir"
done