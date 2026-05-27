id #see the main actual group
id -gn #Only showcase the name of the main group
touch ~/test_grupo_heredado.txt #create an archive and see which group inherits
ls -la ~/test_grupo_heredado.txt

#the group is the main group of the user

#show the actual group
id -gn
echo "Grupo actual: $(id-gn)"

#create an archive before newgrp

touch ~/antes_de_newgrp.txt
ls -la ~/antes_de_newgrp.txt

#change to "developers" group
#check if the active group changed
id -gn
echo "Nuevo grupo activo:$(id-gn)"
#Create group in the subshell
touch ~/dentro_de_newgrp.txt
ls -la ~/dentro_de_newgrp.txt
#the group is now dev
#Create a directoy
mkdir -p ~/proyecto_dev/src
ls -la ~/
exit
#Verify to return to the original group
id -gn
echo "Grupo restaurado: $(id -gn)"
#compare archives

ls -la ~/antes_de_newgrp.txt
~/dentro_de_newgrp.txt
# newgrp create a new subshell -demostrable
echo "PID del shell actual: $$"
newgrp desarolladores
echo "PID dentro de newgrp: $$"
#The PID is differente, is a minor process

#create a new group with a password
sudo groupadd grupo_restringido
sudo gpasswd grupo_restringido
#the sistem will ask for a password in the group
#Password; AM

#An user that doesnt belongs can join if it knows the password
newgrp grupo_restringido
#it will ask for the password, if it is correct, it will join temporaly
id -gn
exit
