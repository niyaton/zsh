function encrypt(){
	openssl aes-256-cbc -e -in $1 -out $1.encrypted
}

function decrypt(){
	openssl aes-256-cbc -d -in $1 -out $1.plain
}
