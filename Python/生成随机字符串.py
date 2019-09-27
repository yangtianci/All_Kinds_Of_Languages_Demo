
#coding=utf-8 
#
#
# 使用方式 : python file path count 
# 
# 


import random 
import string 
import sys 


def CreatRandomString(count): 

	totalString = '' 

	needtime = int(count) + 1 

	for X in xrange(1,needtime):
		
		ran_str = ''.join(random.sample(string.ascii_letters + string.digits, 1)) 
		totalString+=ran_str

	pass

	return totalString 
 
	pass


count = sys.argv[1]  


randomStr = CreatRandomString(count)

print('---随机字符串 Strat ---') 

print(randomStr)

print('---随机字符串 End ---') 


print('随机字符串长度' + str(len(randomStr)))  




# 中文字符串 
# def GBK2312():
#  head = random.randint(0xb0, 0xf7)
#  body = random.randint(0xa1, 0xfe)
#  val = f'{head:x}{body:x}'
#  str = bytes.fromhex(val).decode('gb2312')
#  return str






