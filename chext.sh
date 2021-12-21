#chext [-d|--] расширение файла
#опции:
d=0

while [ -n "$1" ]
do
case "$1" in
    --) shift
        break ;;
    -d) d="1" ;;
    -*) echo "$1 неподдерживаемая опция"
        echo error message >&2
        exit;;
esac
shift
done


#проверка существования расширения и файлов
if [ -n "$1" ]
then
    ext=$1
    shift
else
    echo "Не указано расширение" >&2
    exit
fi

if [ -z "$1" ]
then 
    echo "Не указан файл" >&2
    exit
fi



#сам алгоритм
while [ -n "$1" ]
do
#проверка существования файла
if ! [ -f $1 ]
then
    echo "Файл не найден" >&2
    exit 2
fi

case $1 in
    (*.*) extension=${1%.*}.$ext;;
    (*)   extension=${1}.$ext;;
esac
if [ "$d" -ne "1" ]
then
    mv "$1" "$extension"
else
    echo $1 $extension
fi

shift
done