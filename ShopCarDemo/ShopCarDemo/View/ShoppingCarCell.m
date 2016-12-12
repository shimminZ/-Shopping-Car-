//
//  ShoppingCarCell.m
//  GuoJi Bluetooth
//
//  Created by zhang on 16/11/14.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ShoppingCarCell.h"

@interface ShoppingCarCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *labContentView;
@property (weak, nonatomic) IBOutlet UILabel *leftReduce;
@property (weak, nonatomic) IBOutlet UILabel *centerNum;
@property (weak, nonatomic) IBOutlet UILabel *rightAdd;

/** cdImage*/
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

/** cdName*/
@property (weak, nonatomic) IBOutlet UILabel *showName;

/** cdPrice*/
@property (weak, nonatomic) IBOutlet UILabel *showNowPrice;

/** 选中按钮*/
@property (weak, nonatomic) IBOutlet UIButton *chooseCdBtn;

/** 记录最终选中的个数*/
@property (nonatomic,assign)NSInteger  addCount;


@property (weak, nonatomic) IBOutlet UITextField *inputNumTF;
@property (weak, nonatomic) IBOutlet UIButton *leftReduce2;
@property (weak, nonatomic) IBOutlet UIButton *rightAdd2;

@end

@implementation ShoppingCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.addCount = 1;
    
    [self settingSubViews];
    
    /** 设置lab的边角*/
    [self setAddReduceBorderLayer];
    
    /** lab可以点击*/
    [self setReduceAndAddLabCanClick];
    
    
    
}

-(void)settingSubViews{
    
    self.editContentView.hidden = YES;
    
    self.inputNumTF.delegate = self;
    
    self.showImage.layer.cornerRadius = 5;
    
    self.showImage.clipsToBounds = YES;
}


/** lab可以点击*/
-(void)setReduceAndAddLabCanClick{
    
    self.leftReduce.userInteractionEnabled = YES;
    
    self.rightAdd.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftClick:)];
    
    [self.leftReduce addGestureRecognizer:tapLeft];
    
    UITapGestureRecognizer *tapRight = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightClick:)];
    
    [self.rightAdd addGestureRecognizer:tapRight];
    
}

/** 手势事件  左边递减*/
-(void)leftClick:(UITapGestureRecognizer *)tap{
    
    self.addCount--;
    
    if (self.addCount<=0)   self.addCount = 1;
    
    [self clickLeftOrRight:self.leftReduce];
    
}

/** 手势事件  右边递增*/
-(void)rightClick:(UITapGestureRecognizer *)tap{
    self.addCount++;
    [self clickLeftOrRight:self.rightAdd];
    
}

/** 计算最终的商品个数*/
-(void)clickLeftOrRight:(id)obj{
    
    if ([obj isKindOfClass:[UILabel class]]) {
        self.centerNum.text = [NSString stringWithFormat:@"%zd",self.addCount];
    }else{
        self.inputNumTF.text = [NSString stringWithFormat:@"%zd",self.addCount];
    }
    
    self.cdModel.cdChooseCount = [NSString stringWithFormat:@"%zd",self.addCount];
    
    self.showNowPrice.text = [NSString stringWithFormat:@"%zdx%@",self.addCount,self.cdModel.cdPrice];
    
    if ([self.delegate respondsToSelector:@selector(clickLeftReduceOrRightAddGetTotalMoney)]) {
        [self.delegate clickLeftReduceOrRightAddGetTotalMoney];
    }
}


/** 设置lab的边角*/
-(void)setAddReduceBorderLayer{
    
    [self.labContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.layer.borderWidth = 0.5;
        
        obj.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.4].CGColor;
    }];
    
}



//重写DetailCDModel的set方法
-(void)setCdModel:(DetailCDModel *)cdModel{
    
    _cdModel = cdModel;
    
    //名字
    self.showName.text = cdModel.cdName;
    //图片
    self.showImage.image = [UIImage imageNamed:cdModel.cdImage];
    //价格
    self.showNowPrice.text = [NSString stringWithFormat:@"%@x%@",cdModel.cdChooseCount,cdModel.cdPrice];
    
    
    self.centerNum.text = cdModel.cdChooseCount;
    
    self.inputNumTF.text = cdModel.cdChooseCount;
    
    
    //判断是否选中
    if (cdModel.isChoose) {
        [self.chooseCdBtn setImage:[UIImage imageNamed:@"color_choose"] forState:UIControlStateNormal];
        
    }else{
         [self.chooseCdBtn setImage:[UIImage imageNamed:@"color_no_choose"] forState:UIControlStateNormal];
    }

}


//选中cell
- (IBAction)clickChooseBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickChooseDeliver:detailModel:)]) {
        
        [self.delegate clickChooseDeliver:self.cdModel detailModel:self.detailModel];
    }
}


//左边递减
- (IBAction)clickLeftReduce2:(id)sender {
    
    if (self.addCount<=0)   self.addCount = 1;
    
    self.addCount --;
    
    [self clickLeftOrRight:sender];
}

//右边递增
- (IBAction)clickRightAdd2:(id)sender {
    
    self.addCount++;
    
    [self clickLeftOrRight:sender];

}

//删除 事件
- (IBAction)deleteCdClick:(id)sender {
    
    BOOL isContain = [self.detailModel.detailDateArr containsObject:self.cdModel];
    
    if (isContain) [self.detailModel.detailDateArr removeObject:self.cdModel];
    
    BOOL isCountMore0 = self.detailModel.detailDateArr.count<=0;
    
    if (isCountMore0) [self.shopCarModel.headModelArr removeObject:self.detailModel];
    
    if (self.deleteOneSingleCell) {
        self.deleteOneSingleCell();
    }
}


#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.cdModel.cdChooseCount = textField.text;
    
    self.addCount = [textField.text integerValue];
    
    [self clickLeftOrRight:textField];
}


@end
