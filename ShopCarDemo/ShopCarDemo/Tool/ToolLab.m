//
//  ToolLab.m
//  YourBigJb
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ToolLab.h"
@implementation ToolLab

@end


@implementation NavTitleViewLab
//frame 调用
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

//加载xib 调用
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.textColor = [UIColor whiteColor];
}

+(instancetype)titleViewWithTitle:(NSString *)title{
    
    NavTitleViewLab *lab = [[NavTitleViewLab alloc]initWithFrame:CGRectZero];
    lab.clipsToBounds = YES;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = title;
    [lab sizeToFit];
    return lab;
}

@end


