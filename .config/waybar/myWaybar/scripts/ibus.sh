status=$(ibus engine | grep BambooUs)

if [ -n "$status" ]
then
   ibus engine Bamboo >> /dev/null
else
   ibus engine BambooUs >> /dev/null
fi

## Nếu các ông dùng cái này thì chọn phương thức nhập là Bamboo Và BambooUS nha
