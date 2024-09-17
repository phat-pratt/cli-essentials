
# reactotron
alias connectron="adb reverse tcp:9090 tcp:9090"

# List directories
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Quick edit of zshrc
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"

# functions

# generate a random password
genpasswd() {
    openssl rand -base64 20
}

# create new branch and set upstream
branch() {
    if [ -z "$1" ]; then
        echo "Usage: branch <branchname>"
    else
        git checkout -b "$1" && git push --set-upstream origin "$1"
    fi
}

# create new branch from a jira ticket url
jbranch() {
   if [ -z "$1" ]; then
        echo "Usage: branch <branchname> or branch <Jira URL>"
    else
        if [[ $1 == https://betterc.atlassian.net/browse/* ]]; then
            # Extract the Jira ticket number from the URL
            ticket=$(echo $1 | grep -oE 'AN-[0-9]+')
            if [ -n "$ticket" ]; then
                branchname="pratt/$ticket"
            else
                echo "Invalid Jira URL. Unable to extract ticket number."
                return 1
            fi
        else
            branchname="$1"
        fi

        if git checkout -b "$branchname" && git push --set-upstream origin "$branchname"; then
            echo "Branch created and pushed successfully."
            echo "Current branch: $(git rev-parse --abbrev-ref HEAD)"
            echo "Tracking: $(git rev-parse --abbrev-ref --symbolic-full-name @{u})"
        else
            echo "Failed to create or push the branch."
        fi
    fi
}

# check weather for location
weather() {
    curl "wttr.in/$1"
}
