//
//  ShoppingCarCell.h
//  GuoJi Bluetooth
//
//  Created by zhang on 16/11/14.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoShopCarModel.h"

typedef void(^deleteOneSingleCell)();

@protocol ShoppingCarCellDelegate <NSObject>

-(void)clickChooseDeliver:(DetailCDModel *)cDmodel detailModel:(DetailModel *)detailModel;
-(void)clickLeftReduceOrRightAddGetTotalMoney;


@end

@interface ShoppingCarCell : UITableViewCell

@property (nonatomic,strong)GoShopCarModel *shopCarModel ;

@property (nonatomic,strong)DetailModel *detailModel;

@property (nonatomic,strong)DetailCDModel *cdModel;

@property (nonatomic,assign)id <ShoppingCarCellDelegate> delegate;

@property (nonatomic,copy)deleteOneSingleCell deleteOneSingleCell;

@property (weak, nonatomic) IBOutlet UIView *editContentView;

@end
