function preexec_logger(){
	COMMAND=$3
	IS_INSIDE_REPOSITORY=`command git rev-parse --is-inside-work-tree 2> /dev/null`
	REPOSITORY_ROOT_PATH=`command git rev-parse --show-toplevel 2> /dev/null`

	if [[ $COMMAND =~ ^git\  ]] && [ "$IS_INSIDE_REPOSITORY" = "true" ]; then
		TIMESTAMP=`date +%s`
		BEFORE_SHA=`command git rev-parse --verify HEAD`
		CURRENT_BRANCH=`command git rev-parse --abbrev-ref HEAD`
		CURRENT_REMOTE_BRANCH=`command git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD) 2> /dev/null`
		USER_NAME=`command git config user.name`
		USER_EMAIL=`command git config user.email`
		REPOSITORY_ROOT_BASE_NAME=`basename $REPOSITORY_ROOT_PATH`
		REPOSITORY_ROOT_DIR_NAME=`dirname $REPOSITORY_ROOT_PATH`
		CURRENT_DIR_NAME=`pwd -P`

		echo \{\"ts\":$TIMESTAMP,\"type\":\"LOG\",\"command\":\"$COMMAND\",\"user_name\":\"$USER_NAME\",\"user_email\":\"$USER_EMAIL\",\"sha\":\"$BEFORE_SHA\",\"root_path\":\"$REPOSITORY_ROOT_BASE_NAME\",\"execute_path\":\"${CURRENT_DIR_NAME#$REPOSITORY_ROOT_DIR_NAME/}\",\"branch\":\"$CURRENT_BRANCH\",\"remote_branch\":\"$CURRENT_REMOTE_BRANCH\"\}, >> $REPOSITORY_ROOT_PATH/.git/.git_history
	fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_logger
