//
//  NSString+CaculatrLength.m
//  YourBigJb
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NSString+CaculatrLength.h"

@implementation NSString (CaculatrLength)

-(CGSize)caculateStrLength:(NSString *)str{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    return size;
}

@end
