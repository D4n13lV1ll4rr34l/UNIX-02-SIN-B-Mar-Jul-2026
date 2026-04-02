# A: Setup
# check if gpg is installed
which gpg
# show gpg version
gpg --version
# generate my key pair
gpg --full-generate-key
# list public keys
gpg --list-keys
# list secret keys with long ID
gpg --list-secret-keys --keyid-format=long
# B: Key exchange with David
# export my public key to share with David
gpg --armor --export danielvillarrealolmedo@gmail.com > mi_llave.asc
# import David´s public key
gpg --import llave_david.asc
# verify David´s key was imported
gpg --list-keys
# C: Encryption
# encrypt file using David´s public key so only he can read it
gpg --encrypt --armor -r davidsitotorres8@gmail.com doc_no_cifrado.txt
# decrypt file received from David
gpg --decrypt Daniel_doc_cifrado.txt
# D: Signing
# sign in plain text so content is still readable
gpg --clearsign doc_no_cifrado.txt
# sign in binary 
gpg --sign doc_no_cifrado.txt
# create a separate file
gpg --detach-sign doc_no_cifrado.txt
# verify David´s clearsign document
gpg --verify Daniel_doc_no_cifrado_firmado.txt
# verify David´s binary signed document
gpg --verify Daniel_doc_no_cifrado_firmado_binario.txt
# verify David´s detached signature
gpg --verify Daniel_firma_separada_doc_no_cifrado.sig Daniel_doc_no_cifrado.txt
# E: Web of trust
# set trust level 4 because i know david in real life, so i have plenty of trust in him
gpg --edit-key davidsitotorres8@gmail.com
# sign David´s key to confirm his identity
gpg --sign-key davidsitotorres8@gmail.com
# verify again to see the trust warning is gone
gpg --verify Daniel_doc_no_cifrado_firmado.txt
# F: Encrypt
# encrypt and sign in one command
gpg --encrypt --sign --armor -r davidsitotorres8@gmail.com doc_no_cifrado.txt
# decrypt David´s file and verify his signature at the same time
gpg --decrypt doc_cifrado_y_firmado.txt > resultado.txt
# check the content of the decrypted file
cat resultado.txt
