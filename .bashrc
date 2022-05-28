# SSH Agent
pkill ssh-agent
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

# Exports
export LESS="-irMX"
