//
//  ShoppingCarView.h
//  GuoJi Bluetooth
//
//  Created by zhang on 16/11/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoShopCarModel.h"

@protocol ShoppingCarViewDelegate <NSObject>

-(void)ShoppingCarViewDelegateMethodClickSection:(NSInteger)section;

@end

@interface ShoppingCarView : UIView

/** 区头name*/
@property (nonatomic,copy)NSString *name;

/** 记录区 */
@property (nonatomic,assign)NSInteger  section;

/** detailModel*/
@property (nonatomic,strong)DetailModel *detailModel;


@property (nonatomic,assign)id<ShoppingCarViewDelegate>delegate;

+(instancetype)loadShoppingCarViewFromIxb;

@end
