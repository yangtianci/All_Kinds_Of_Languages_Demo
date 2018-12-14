
echo "Hello World !"


testVar="阿尔hi埃尔文化如挖客户如渴望"
echo $testVar


meth(){

echo "输入任意数字开始计算"

read

num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
echo '两个数字相等!'
else
echo '两个数字不相等!'
fi

}

meth
