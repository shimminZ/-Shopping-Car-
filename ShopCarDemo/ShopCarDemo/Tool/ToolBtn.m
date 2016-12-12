//
//  ToolBtn.m
//  GuoJi Bluetooth
//
//  Created by zhang on 16/10/13.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ToolBtn.h"

@implementation ToolBtn

@end


@implementation NavEditerBtn

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

+(instancetype)buttonWithType:(UIButtonType)buttonType{
    NavEditerBtn *btn = [super buttonWithType:buttonType];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.backgroundColor = [UIColor redColor];


}

@end
