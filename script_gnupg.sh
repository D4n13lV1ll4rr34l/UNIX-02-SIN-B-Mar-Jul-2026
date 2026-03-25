gpg --armor --export-secret-keys
gpg --import llave_david.asc
gpg --list-keys
gpg --clearsign doc_no_cifrado.txt
gpg --sign doc_no_cifrado.txt
gpg --detach-sign doc_no_cifrado.txt
gpg --encrypt --sign --armor -r davidsitotorres8@gmail.com doc_no_cifrado.txt
gpg --edit-key davidsitotorres8@gmail.com # trust level 4 (full) - David is my classmate
gpg --sign-key davidsitotorres8@gmail.com
gpg --verify Daniel_doc_no_cifrado_firmado.txt
gpg --verify Daniel_doc_no_cifrado_firmado_binario.txt
gpg --verify Daniel_firma_separada_doc_no_cifrado.sig Daniel_doc_no_cifrado.txt
gpg --verify Daniel_firma_separada_doc_no_cifrado.sig Daniel_doc_no_cifrado.txt
gpg --decrypt Daniel_doc_cifrado.txt
