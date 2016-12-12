//
//  ShoppingCarView.m
//  GuoJi Bluetooth
//
//  Created by zhang on 16/11/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ShoppingCarView.h"

@interface ShoppingCarView ()

/** 显示名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

/** 区选中的按钮*/
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@end

@implementation ShoppingCarView

+(instancetype)loadShoppingCarViewFromIxb{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.nameLab.layer.cornerRadius = 3;
    
    self.nameLab.backgroundColor = RGBA(239, 34, 109, 1);
    
    self.nameLab.clipsToBounds = YES;
}

-(void)setName:(NSString *)name{
    _name = name;
    self.nameLab.text = name;
}

//点击了全选
- (IBAction)clickAllSelected:(id)sender {
    MYLog(@"区头全选");
    if ([self.delegate respondsToSelector:@selector(ShoppingCarViewDelegateMethodClickSection:)]) {
        [self.delegate ShoppingCarViewDelegateMethodClickSection:self.section];
    }
    
}

//重写DetailModel的set方法，给子控件赋值
-(void)setDetailModel:(DetailModel *)detailModel{
    
    _detailModel = detailModel;
    
    self.nameLab.text = detailModel.name;
    
    if (detailModel.isChoose) {
        [self.chooseBtn setImage:[UIImage imageNamed:@"color_choose"] forState:UIControlStateNormal];
    }else{
        [self.chooseBtn setImage:[UIImage imageNamed:@"color_no_choose"] forState:UIControlStateNormal];
    }
    
}


@end
