#!/bin/bash

# 1. Validate that exactly two arguments were passed
if [ $# -ne 2 ]; then
    echo "Error: Faltan argumentos." >&2
    echo "Uso: $0 <nombre> <dominio_objetivo>" >&2
    exit 1
fi

# Assign arguments to readable variables
NOMBRE=$1
DOMINIO=$2

# 2. Ping the domain
# -c 1: Sends only 1 packet (so it doesn't run infinitely)
# -W 2: Waits a maximum of 2 seconds for a response
# > /dev/null 2>&1: Hides the ping output from the screen
if ping -c 1 -W 2 "$DOMINIO" > /dev/null 2>&1; then
    RESULTADO="success"
    echo "¡El ping a $DOMINIO fue exitoso!"
else
    RESULTADO="failure"
    echo "Error: No se pudo hacer ping a $DOMINIO."
fi

# 3. Get the current date and time in ISO format (Year-Month-Day Hour:Min:Sec)
FECHA_HORA=$(date "+%Y-%m-%d %H:%M:%S")

# 4. Save the results to the CSV file
# If the file does not exist, optionally create the header first
if [ ! -f "resultados.csv" ]; then
    echo "Nombre,Dominio,Resultado,Fecha_Hora" > resultados.csv
fi

# Append the new line to the CSV (the >> operator appends to the end of the file)
echo "$NOMBRE,$DOMINIO,$RESULTADO,$FECHA_HORA" >> resultados.csv

echo "Resultado guardado en resultados.csv"