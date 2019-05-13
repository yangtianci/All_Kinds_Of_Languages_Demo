//
//  BaseModel.m
//  NormalDemo
//
//  Created by YangTianCi on 2017/12/19.
//  Copyright © 2017年 ytc. All rights reserved.
//


#if DEBUG

#define NormalValue @"DebugValueException"

#else

#define NormalValue @" "

#endif


#import "BaseModel.h"

@implementation BaseModel


+(void)testMethod{
    
    NSLog(@"%@",NormalValue);
    
}

-(instancetype)initWithDictionary:(NSDictionary*)dictionary{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            NSLog(@"后台数据类型解析为空");
            obj = @" ";
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
            NSLog(@"后台数据类型返回为Number");
            obj = [NSString stringWithFormat:@"%@",obj];
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            obj = [obj mutableCopy];
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            obj = [obj mutableCopy];
        }
        [self setValue:obj forKey:key];
    }];
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"模型属性中缺少了: %@\n后台对应返回值为: %@",key,value);
    
}


@end
