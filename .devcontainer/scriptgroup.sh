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