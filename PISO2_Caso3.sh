#!/bin/bash
echo "SCRIPT PARA GUARDAR ARCHIVOS CON EXTENSION .log DE /var/log"
echo "INTRODUCE EL NOMBRE DE USUARIO"
read usr
tar -cvf /home/$usr/log.tar /var/log/*.log

ls -ad /var/log/*/ > texto.txt

for line in $(cat texto.txt); do
    if [ -f $line*log ]; then
        echo "Guardando contenido de: $line"
        tar -rvf /home/$usr/log.tar $line*.log
    else
        echo -e "\e[1;31mCarpeta $line sin archivos .log\e[0m"
    fi
done

echo "ARCHIVOS .log GUARDADOS CON EXITO EN /home/$usr/log.tar"
mkdir -p /home/$usr/backup
echo "COPIA DE SEGURIDAD CREADA EN /home/$usr/backup"
cp /home/$usr/log.tar /home/$usr/backup
echo "LOS ARCHIVOS GUARDADOS SON: "
echo -e "Los archivos dentro de \e[1;31m/home/$usr/log.tar\e[0m son: \n "
tar -tf /home/$usr/log.tar | grep -o [^/]*$
rm texto.txt

exit 0

