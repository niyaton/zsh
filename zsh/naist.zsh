#ssh connection via sh.naist.jp
function tssh(){
  echo create tunnel to $1
  ssh -f -L 10000:$1:22 sh.naist.jp -g sleep 10
  echo connect to $1
  ssh -p 10000 -o HostKeyAlias=$1 localhost
}
