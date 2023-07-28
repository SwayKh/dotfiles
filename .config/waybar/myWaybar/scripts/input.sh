input=$(ibus engine | grep BambooUs)

if [ -n "$input" ]
then
   echo EN
else
   echo VN
fi
