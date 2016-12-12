//
//  GoShopCarModel.h
//  GuoJi Bluetooth
//
//  Created by zhang on 16/11/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


/*****************最里面层的model,字段cdPrice、cdImage、cdName*******************/

@interface DetailCDModel : NSObject

/** 价格*/
@property (nonatomic,copy)NSString *cdPrice;

/** 图片*/
@property (nonatomic,copy)NSString *cdImage;

/** 歌曲名字*/
@property (nonatomic,copy)NSString *cdName;

/** cd的个数*/
@property (nonatomic,copy)NSString *cdChooseCount;

/** 记录是否选中*/
@property (nonatomic,assign)BOOL  isChoose;


-(instancetype)initWithCdModelWithDic:(NSDictionary *)dic;

@end


/**************************中间层model,字段name********************************/


@interface DetailModel : NSObject


/** 歌手名字*/
@property (nonatomic,copy)NSString *name;

/** 区头是否选中*/
@property (nonatomic,assign)BOOL  isChoose;

/** 每个区的价格总和*/
@property (nonatomic,assign)NSInteger sectionTotalPrice;

/** 记录选中的cell*/
@property (nonatomic,strong)NSMutableArray *recordCdModelSelected ;

/** 存放model*/
@property (nonatomic,strong)NSMutableArray *detailDateArr ;

/** 记录选中的行*/
@property (nonatomic,assign)NSInteger  indexPathRow;

/** 记录选中的区*/
@property (nonatomic,assign)NSInteger  indexPathSection;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end


/**************************最外层model,字段name********************************/

@interface GoShopCarModel : NSObject


/** 记录区是否被全选*/
@property (nonatomic,strong)NSMutableArray *recordArr;

/** 存放model*/
@property (nonatomic,strong)NSMutableArray *headModelArr ;

+(instancetype)goShopCarModelWith:(NSArray *)arr;
-(instancetype)initWithModelArr:(NSArray *)arr;
@end
