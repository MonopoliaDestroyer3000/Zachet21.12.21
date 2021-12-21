#groupname [-f file] gid
file="/etc/group"
gid=""

#считывание
while [ -n "$1" ]
do
    case "$1" in
        -f) shift
            file=$1;;
        -*) echo "Такого параметра нет" >&2
            exit 2;;
        *) gid=$1;;
    esac
    shift
done

#проверка на существвование файла
if [ -f $file ]
then
    echo "Файл найден"
else
    echo "Файл не найден" >&2
    exit 2
fi

GidGroup=$(cut -d ':' -f 3 $file | grep -x -n -- $gid)

if [[ "$GidGroup" == "" ]]; then
    echo "группа с таким Gid нет" >&2
    exit 1
fi

num="${GidGroup%:*}"
str=`sed "${num}q;d" $file`

echo $str | cut -d ':' -f 1
exit 0