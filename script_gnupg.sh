gpg --armor --export-secret-keys
gpg --import llave_david.asc
gpg --list-keys
gpg --clearsign doc_no_cifrado.txt
gpg --sign doc_no_cifrado.txt
gpg --detach-sign doc_no_cifrado.txt
gpg --encrypt --sign --armor -r davidsitotorres8@gmail.com doc_no_cifrado.txt
