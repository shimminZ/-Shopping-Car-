//
//  GoShopCarModel.m
//  GuoJi Bluetooth
//
//  Created by zhang on 16/11/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "GoShopCarModel.h"


@implementation DetailCDModel

+(instancetype)detailCdModelWithDic:(NSDictionary *)dic{
    
    DetailCDModel *model = [[DetailCDModel alloc]initWithCdModelWithDic:dic];
    
    return model;
}

-(instancetype)initWithCdModelWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.cdName  = dic[@"CDname"];
        self.cdPrice = dic[@"CDprice"];
        self.cdImage = dic[@"CDimage"];
        self.cdChooseCount = dic[@"CDchooseCount"];
    }
    return self;
}

@end


@implementation DetailModel

+(instancetype)detailModelWithDic:(NSDictionary *)dic{
    DetailModel *model = [[DetailModel alloc]initWithDic:dic];
    model.name = dic[@"name"];
    return model;
}


-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self= [super init]) {
        
        NSMutableArray *mutableArr = [NSMutableArray array];
        NSInteger value = 0;
        NSInteger sum = 0;
        for (NSDictionary *dicCd  in dic[@"detail"]) {
            DetailCDModel *cdModel = [DetailCDModel detailCdModelWithDic:dicCd];
            
            value = [cdModel.cdPrice integerValue];
            sum = sum+value;
            [mutableArr addObject:cdModel];
        }
        self.sectionTotalPrice = sum;
        self.detailDateArr = mutableArr;
        self.recordCdModelSelected = [NSMutableArray array];
        NSLog(@"sectionTotalPrice  %zd",self.sectionTotalPrice);

    }
    return self;
}


@end

@implementation GoShopCarModel

+(instancetype)goShopCarModelWith:(NSArray *)arr{
    
    GoShopCarModel *model = [[GoShopCarModel alloc]initWithModelArr:arr];
    
    return model;
}

-(instancetype)initWithModelArr:(NSArray *)arr{
    
    if (self == [super init]) {
        NSMutableArray *mutableArr = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            DetailModel *detailModel = [DetailModel detailModelWithDic:dic];
            [mutableArr addObject:detailModel];
            self.recordArr = [NSMutableArray array];
        }
        self.headModelArr = mutableArr;
        
    }
    return self;
}

@end
