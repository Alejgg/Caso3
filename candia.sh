#!/bin/sh

while [ "$opcion" != 0 ]
do

 echo  "MENU"
 echo "----------"
 echo "1.- Crear un usuario"
 echo "2.- Crear/crear la contraseña de un usuario"
 echo "3.- Crear un grupo"
 echo "4.- Añadir un usuario a un grupo"
 echo "5.- Borrar un usuario"
 echo "6.- Borrar un grupo"
 echo "7.- Salir"

 read opcion

 case $opcion in
 1)
  echo "--CREAR UN USUARIO--"
  echo "insertar el nombre del nuevo usuario: "
  read user
  adduser $user
  ;;

 2)
  echo "--CAMBIAR/CREAR LA CONTRASEÑA DE UN USUARIO--"
  echo "ingresa el nombre del usuario para cambiar la contraseña"
  read user2
  passwd $user2
  ;;

 3)
  echo "--CREAR UN GRUPO--"
  echo "ingresa el nombre del grupo"
  read grupo
  groupadd $grupo
  ;;

 4)
  echo "--AÑADIR UN USUARIO AL GRUPO--"
  echo "Ingresa el nombre del usuario"
  read user3
  echo "Ingresa el nombre del grupo"
  read grupo2
  sudo addgroup $user3 $grupo2
  ;;

 5)
  echo "--ELIMINAR UN USUARIO--"
  echo "Ingresa el nombre del usuario"
  read userd
  deluser $userd
  ;;

 6)
  echo "--ELIMINAR UN GRUPO--"
  echo "Ingresa el grupo a eliminar"
  read grupod
  delgroup $grupod
 ;;

  esac
 done
exit 0
