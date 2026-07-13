#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm && exit 1
}

# Ctrl+C
trap ctrl_c INT

# Variables Globales
main_url="https://htbmachines.github.io/bundle.js"

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}"
  echo -e "\t${yellowColour}u)${endColour}${grayColour} Descargar o actualizar archivos necesarios${endColour}"
  echo -e "\t${yellowColour}m)${endColour}${grayColour} Buscar por un nombre de maquina${endColour}"
  echo -e "\t${yellowColour}i)${endColour}${grayColour} Buscar por direccion IP${endColour}"
  echo -e "\t${yellowColour}h)${endColour}${grayColour} Mostrar este panel de ayuda${endColour}\n"
}

function updateFiles(){

  if [ ! -f bundle.js ]; then
    tput civis
    echo -e "\n${yellowColour}[+]${endColour}${grayColou} Descargando archivos necesarios...${endColour}"
    curl -s "$main_url > bundle.js"
    js-beautify bundle.js | sponge bundle.js
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Todos los archivos han sido descargados${endColour}"
    tput cnorm
  else
    tput civis
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Comprobando si hay actualizaciones pendientes...${endColour}"
    curl -s "$main_url > bundle.temp.js"
    js-beautify bundle_temp.js | sponge bundle_temp.js
    md5_temp_value=$(md5sum bundle_temp.js | awk '{print $1}')
    md5_original_value=$(md5sum bundle.js | awk '{print $1}')

    if [ "$md5_temp_value" == "$md5_original_value" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} No se han detectado actualizaciones, lo tienes todo al dia ;)${endColour}"
      rm bundle_temp.js
    else
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se han encontrado actualizaciones disponibles${endColour}"
      sleep 2

      rm bundle.js && mv bundle_temp.js bundle.js

      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Los archivos han sido actualizados${endColour}"
    fi

    tput cnorm
  fi
}

function searchMachine(){
  machineName="$1"

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Listando las propiedades de la maquina${endColour}\n"

cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d  '"' | tr -d ',' | sed 's/^ *//'
}

function searchIP(){
  ipAddress="$1"

  machineName="$(cat bundle.js | grep "ip: \"$ipAddress\"" -B 3 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',')"

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} La Maquina correspondiente para la IP${endColour}${blueColour} $ipAddress${endColour}${grayColour} es${endColour}${purpleColour} $machineName${endColour}\n"
}
