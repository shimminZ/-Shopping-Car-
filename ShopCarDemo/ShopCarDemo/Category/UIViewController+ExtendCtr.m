//
//  UIViewController+ExtendCtr.m
//  RealWriteProBaiSI
//
//  Created by zhang on 16/10/31.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "UIViewController+ExtendCtr.h"
#import "MBProgressHUD.h"

@implementation UIViewController (ExtendCtr)

-(void)loadHudShowLoading{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.tag = 100;
    hud.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    hud.label.text = @"删除中···";
    hud.label.backgroundColor = RandomColor;
    hud.bezelView.backgroundColor = RandomColor;
}


-(void)hiddenHud{
    MBProgressHUD *hud  = [[[UIApplication sharedApplication].delegate window] viewWithTag:100];
    [hud hideAnimated:YES];
    
}




@end
