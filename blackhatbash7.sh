#!/bin/bash

# ==============================================================================
# SCRIPT: Ejemplos de Filtrado con Grep
# DESCRIPCIÓN: Este script recopila las diferentes formas de usar el comando 
#              'grep' para filtrar información de archivos y flujos de datos.
# ==============================================================================

# 1. Filtrado básico de una cadena específica en un archivo
# Extrae cualquier línea que contenga exactamente la IP mencionada dentro de 'log.txt'
grep "35.237.4.214" log.txt

# 2. Filtrado de múltiples patrones usando la barra invertida y tubería (condición OR)
# Busca líneas que contengan la primera IP O la segunda IP
grep "35.237.4.214\|13.66.139.0" log.txt

# 3. Filtrado de múltiples patrones usando el argumento -e
# Logra el mismo resultado anterior (OR) pero de una forma más limpia y legible
grep -e "35.237.4.214" -e "13.66.139.0" log.txt

# 4. Uso de tuberías (|) para filtrar la salida de otro comando
# El comando 'ps' lista los procesos del sistema, y 'grep' filtra solo la línea con "TTY"
ps | grep TTY

# 5. Filtrado insensible a mayúsculas y minúsculas usando la bandera -i
# Por defecto grep distingue entre mayúsculas y minúsculas. '-i' ignora esta diferencia.
ps | grep -i tty

# 6. Exclusión de líneas usando el argumento -v
# Muestra todas las líneas EXCEPTO aquellas que coincidan con el patrón indicado
# (Nota: Aquí puedes agregar el patrón que desees excluir al final, por ejemplo: grep -v "patrón")