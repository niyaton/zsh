function bookmark(){
	local b
	b=`grep -e "^$1 " ~/.zsh/bookmarks`
	#echo $b
	if [[ -z $b ]]; then
		echo "new bookmark $1"
		echo $1 `pwd` >> ~/.zsh/bookmarks
	else
		dir=`echo $b | cut  -d ' ' -f2`
		if [[ `pwd` = $dir ]]; then
			echo "exist bookmark $1"
		else
			echo "update bookarmk"
			sed -i -e "/^$1 .*/d" ~/.zsh/bookmarks
			echo $1 `pwd` >> ~/.zsh/bookmarks
		fi	
	fi


#	alias $1="cd `pwd`"
	#exist_bookmark $1
	#if ((exist_bookmark $1)){
	#	echo 'exist'
	#} else {
	#	echo 'not exist'
	#}
}

function bcd(){
	b=`grep -e "^$1" ~/.zsh/bookmarks`
	if [[ -z $b ]]; then
		echo "you don't have the bookamrk $1"
	else
		dir=`echo $b| cut -d ' ' -f2`
		echo cd $dir
		cd $dir
	fi
}

touch ~/.zsh/bookmarks
#source ~/.bookmarks
