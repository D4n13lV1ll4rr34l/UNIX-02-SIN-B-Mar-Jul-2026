#!/bin/bash

FILE="output2.txt"
touch "${FILE}"

# El bucle se ejecutará hasta que el archivo tenga un tamaño mayor a cero
until [[ -s "${FILE}" ]]; do
    echo "${FILE} is empty..."
    echo "Checking again in 2 seconds..."
    sleep 2
done

echo "${FILE} tiene texto!"