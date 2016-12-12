//
//  UIBarButtonItem+CustomBarBtnItem.m
//  YourBigJb
//
//  Created by zhang on 16/9/13.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "UIBarButtonItem+CustomBarBtnItem.h"

@implementation UIBarButtonItem (CustomBarBtnItem)


/**
 自定义button
 */
+(instancetype)viewCustomTitle:(NSString *)title   arget:(id)target Method:(SEL)action{
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 44, 44);
    [leftItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [leftItem setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    return buttonItem;
}


@end
