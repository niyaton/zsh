#create tunnel to sd-dev.naist.jp
function tunnel_sd-dev(){
  ssh -f -L 9999:sd-dev.naist.jp:22 sh.naist.jp sleep 10
  echo "tunnel to sd-dev.naist.jp:22 is now available on port 9999 (only 10 sec.)"
}

#create tunnel to sd-dev.naist.jp for VM
function tunnel_sd-dev_vm(){
  ssh -f -L 9999:sd-dev.naist.jp:22 sh.naist.jp -g sleep 10
  echo "tunnel to sd-dev.naist.jp:22 is now available on port 9999 (only 10 sec.)" 
}

#ssh connection via sh.naist.jp
function tssh(){                                                                                                              
  echo create tunnel to $1
  ssh -f -L 10000:$1:22 sh.naist.jp -g sleep 10
  echo connect to $1
  ssh -p 10000 -o HostKeyAlias=$1 localhost
}
