#!/bin/bash
clear
echo "==============================================================================="
multipath -l > /root/multipath_info_"$(date +"%d-%m-%Y_%I-%M-%p").sduarte"
ls -lahr /sys/block/ > /root/blocks_info_"$(date +"%d-%m-%Y_%I-%M-%p").sduarte"
echo "Introduzca la ID de la LUN a despresentar y "
echo -n "presione cualquier tecla para continuar..."
echo ""
read ID_LUN
echo ""
NAME_LUN=`multipath -l $ID_LUN | head -1 | awk '{ print $1 }'`
#NAME_LUN=`cat output | head -1 | awk '{ print $1 }'`

PASOS=`multipath -l $ID_LUN | awk '{ print $3}' | grep ^sd | sort`
#PASOS=`cat output | awk '{ print $3}' | grep ^sd | sort`
echo "==============================================================================="
echo "LUN_NAME: " $NAME_LUN
echo "ID_LUN: " $ID_LUN
echo "PASOS_FOUND:" $PASOS
echo "==============================================================================="
read -n 1 -s -r -p "Presione cualquier tecla para Eliminar de lo contrario Ctrl + C:"
echo ""
echo "Eliminando la LUN $NAME_LUN"
echo "multipath -f /dev/mapper/$NAME_LUN"
multipath -f /dev/mapper/$NAME_LUN
echo ""
echo "Eliminando los pasos"
echo ""
 for i in $PASOS; do
  echo "echo 1 > /sys/block/$i/device/delete"
  echo 1 > /sys/block/$i/device/delete
 done
echo "============="
echo " Finalizado"
echo "============="
exit
