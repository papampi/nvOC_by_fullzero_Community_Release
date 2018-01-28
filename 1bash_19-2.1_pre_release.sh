#!/bin/bash

echo "Backup 1bash to backups/1bash.pre_19-2.1.bak and Making changes"
echo ""
echo "Changes in 1bash:"
echo "Renamed ZM_or_EWBF to EQUIHASH_MINER"
echo "Renamed ETHMINER_or_GENOIL_or_CLAYMORE to ETHASH_MINER"
echo "Added BMINER and BMINER_OPTS"

cd /home/m1/Downloads
if [[ -z $(cat /home/m1/1bash | grep bminer) ]];then
  cp /home/m1/1bash /home/m1/backups/1bash.pre_19-2.1.bak
  sed -i 's/ZM_or_EWBF=/EQUIHASH_MINER=/g' /home/m1/1bash
  sed -i 's/# choose ZM or EWBF miner/# choose "ZM" or "EWBF" or "BMINER" or "BMINER_SSL"/g' /home/m1/1bash
  sed -i '/EWBF_OPTS=/a # Bminer optional arguments. add "--api $IPW:42000" if you want web info'  /home/m1/1bash
  sed -i '/#bminer optional arguments./a BMINER_OPTS="" ' /home/m1/1bash
  sed -i 's/ETHMINER_or_GENOIL_or_CLAYMORE=/ETHASH_MINER=/g' /home/m1/1bash
  wget -N https://raw.githubusercontent.com/papampi/nvOC_by_fullzero_Community_Release/19-2.1/1bash_19-2_1_New_Coins.txt
  sed -i '/ONION_PORT="3633"/r /home/m1/Downloads/1bash_19-2_1_New_Coins.txt' /home/m1/1bash
fi
