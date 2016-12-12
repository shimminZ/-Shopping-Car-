//
//  UIBarButtonItem+CustomBarBtnItem.h
//  YourBigJb
//
//  Created by zhang on 16/9/13.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomBarBtnItem)
/**
 自定义button
 */
+(instancetype)viewCustomTitle:(NSString *)title   arget:(id)target Method:(SEL)action;


@end
