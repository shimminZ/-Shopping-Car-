//
//  ViewController.m
//  ShopCarDemo
//
//  Created by zhang on 16/12/8.
//  Copyright © 2016年 zhang. All rights reserved.

//          /╭-----------—--—-—--—╮\
//          ||                    ||
//          ||    I LOVE iOS!     ||
//          ||                    ||
//          ||  NSLog(@"hello")   ||
//          ||                    ||
//          |╰--------------------╯|\
//          ╰.___________________.╯—\--、_
//                  //___\\           )    、
//        ___________________________/___   \
//       /  oooooooooooooooo  .o.  oooo /, ,—\---╮
//      / ==ooooooooooooooo==.o.  ooo= // /   ▓  /
//     /_==__==========__==_ooo__ooo=_/' /______/
//     "=============================“

#import "ViewController.h"
#import "GoShopCarModel.h"
#import "ShoppingCarCell.h"
#import "ShoppingCarView.h"

#define DefaultBgColor RGBA(244, 244, 244, 1)

typedef void(^deleteSelectedCell)();

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ShoppingCarCellDelegate,ShoppingCarViewDelegate>


/** tableView */
@property (nonatomic,weak)  IBOutlet UITableView *tableView;

/** 结算*/
@property (weak, nonatomic) IBOutlet UIButton *caculaterAndDeleteBtn;

/** 显示总价*/
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

/** 全选按钮*/
@property (weak, nonatomic) IBOutlet UIButton *selectedAllBtn;


/** 返回多少个区的model*/
@property (nonatomic,strong)GoShopCarModel *shopCarModel ;


/** 记录选中的cell*/
@property (nonatomic,strong)NSMutableArray *selectedCellArr;

/** 数据源*/
@property (nonatomic,strong)NSArray *dataArr ;


/** 编辑的状态*/
@property (nonatomic,assign)BOOL  isEditor;

/** 删除block*/
@property (nonatomic,copy) deleteSelectedCell deleteSelectedCell;

@end

static NSString *cellId = @"ShoppingCarCell";

@implementation ViewController

-(NSArray *)dataArr{
    
    if (!_dataArr ) {
        
        NSString *pathStr = [[NSBundle mainBundle]pathForResource:@"ShopCarData" ofType:@"plist"];
        NSArray *dataArr = [NSArray arrayWithContentsOfFile:pathStr];
        
        _dataArr = dataArr;
    }
    
    return _dataArr;
}

-(NSMutableArray *)selectedCellArr{
    
    if (_selectedCellArr == nil) {
        _selectedCellArr = [NSMutableArray array];
    }
    return _selectedCellArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self settingNav];
    
    //加载数据
    [self getDataFromPlist];
    
    //设置tableView
    [self settingTableView];
}

-(void)settingNav{
    
    self.navigationItem.titleView = [NavTitleViewLab titleViewWithTitle:@"购物车"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem viewCustomTitle:@"编辑" arget:self Method:@selector(cliclkEditer:)];
}

-(void)cliclkEditer:(UIButton *)btn{
    
        if (!self.isEditor) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [self.caculaterAndDeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.isEditor = YES;
        
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.caculaterAndDeleteBtn setTitle:@"结算" forState:UIControlStateNormal];
        self.isEditor = NO;
    }
    
    [self.tableView reloadData];
}


//加载数据
-(void)getDataFromPlist{
    
    GoShopCarModel *shopCarModel = [GoShopCarModel goShopCarModelWith:self.dataArr];
    
    self.shopCarModel = shopCarModel;
}


//设置tableView
-(void)settingTableView{
    
    CGFloat space = 10;
    CGFloat temp  = 0;

    self.tableView.contentInset = UIEdgeInsetsMake(temp, temp, space*5, temp);
    
    self.tableView.backgroundColor = DefaultBgColor;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footer = [[UIView alloc]init];
    
    footer.frame = CGRectMake(temp, temp, MainScreen_size_width, space);
    
    footer.backgroundColor = DefaultBgColor;
    
    self.tableView.tableFooterView = footer;

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ShoppingCarCell" bundle:nil] forCellReuseIdentifier:cellId];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //刷新表之前，清除所有添加的数据
    [self.selectedCellArr removeAllObjects];
    
    //此moldel记录了，每个区中有多少行
    DetailModel *detailModel = self.shopCarModel.headModelArr[section];

    return detailModel.detailDateArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //此moldel记录了，每个区中有多少行
    DetailModel *detailModel = self.shopCarModel.headModelArr[indexPath.section];
    //此moldel记录了，每行的内容
    DetailCDModel *cdModel = detailModel.detailDateArr[indexPath.row];
    
    detailModel.indexPathRow = indexPath.row;
    detailModel.indexPathSection = indexPath.section;
    
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    cell.deleteOneSingleCell = ^{
        [self showHud];
    };
    
    
    cell.cdModel = cdModel;
    cell.detailModel = detailModel;
    cell.shopCarModel = self.shopCarModel;
    
    if (self.isEditor) {
        cell.editContentView.hidden = NO;
    }else{
        cell.editContentView.hidden = YES;
        
    }
    
    return cell;
}

-(void)showHud{
    
    [self loadHudShowLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenHud];
        
        [self.tableView reloadData];

    });
}


#pragma mark - UITableViewDelegate
//返回区的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.shopCarModel.headModelArr.count;
}

//返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//返回区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//区头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DetailModel *detailModel = self.shopCarModel.headModelArr[section];

    ShoppingCarView *headV = [ShoppingCarView loadShoppingCarViewFromIxb];
    
    headV.detailModel = detailModel;
    
    headV.section = section;
    
    headV.delegate = self;
    
    return headV;
}

#pragma mark - ShoppingCarCellDelegate 点击cell中选中按钮的代理方法
-(void)clickChooseDeliver:(DetailCDModel *)cDmodel detailModel:(DetailModel *)detailModel{
    
    /** cell 的 section*/
    NSInteger section = [self.shopCarModel.headModelArr indexOfObject:detailModel];

//  cDmodel.isChoose = !cDmodel.isChoose;
    
    
    //先判断section，然后再判断row
    if (detailModel.isChoose) {
        
        /** 如果之前区头是选中的*/
        
        BOOL isContain = [detailModel.recordCdModelSelected containsObject:cDmodel];
        
        if (isContain) [detailModel.recordCdModelSelected removeObject:cDmodel];
        
    }
    
    //判断row是否是选中的
    if (!cDmodel.isChoose) {
        
        cDmodel.isChoose = YES;
        
        BOOL isContain = [detailModel.recordCdModelSelected containsObject:cDmodel];
        
        if (!isContain) [detailModel.recordCdModelSelected addObject:cDmodel];

    }else{
        
        cDmodel.isChoose = NO;
        [detailModel.recordCdModelSelected removeObject:cDmodel];

    }
   
    BOOL isEqual = detailModel.recordCdModelSelected.count == detailModel.detailDateArr.count;
    //判断一个区的cell是否全部选中，如果全选，则让属于该cell的区头也选中
    if (isEqual) {
        
        [self ShoppingCarViewDelegateMethodClickSection:section];
        
        //判断是否全选
        [self addModel:detailModel JudgeSectionSelectedAll:self.shopCarModel.recordArr isChoose:isEqual];
        

    }else{
        //否则，区头就没有选中
        detailModel.isChoose = NO;
        
        //判断是否全选
        [self addModel:detailModel JudgeSectionSelectedAll:self.shopCarModel.recordArr isChoose:isEqual];
    }
    
    
    //计算总价格
    [self caculateTotalMoney];
    
    [self.tableView reloadData];
    
}



#pragma mark -  ShoppingCarCellDelegate
-(void)clickLeftReduceOrRightAddGetTotalMoney{
    
    [self caculateTotalMoney];
}

#pragma mark -- ShoppingCarViewDelegate 点击区头的代理方法
-(void)ShoppingCarViewDelegateMethodClickSection:(NSInteger)section{
    
    DetailModel *detailModel = self.shopCarModel.headModelArr[section];
    
    // 区  是否全选
    [self addOrRemoveModel:detailModel isChoose:!detailModel.isChoose];
    
    //所有cell是否  全选
    [self addModel:detailModel JudgeSectionSelectedAll:self.shopCarModel.recordArr isChoose:!detailModel.isChoose];
    
    //反选
    detailModel.isChoose = !detailModel.isChoose;

    /** 计算总价格*/
    [self caculateTotalMoney];
    
    [self.tableView reloadData];
}

// 区  选中 (区选中--->区中的cell全部选中)
-(void)addOrRemoveModel:(DetailModel *)detailModel isChoose:(BOOL)isChoose{
    
    if (isChoose) {
        
        //区中的所有cell都选中
        [detailModel.detailDateArr enumerateObjectsUsingBlock:^(DetailCDModel  *_Nonnull cdModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            /** 所有的cell选中*/
            cdModel.isChoose = YES;
            
            BOOL isContain = [detailModel.recordCdModelSelected containsObject:cdModel];
            
            if (!isContain) [detailModel.recordCdModelSelected addObject:cdModel];

        }];
        
    }else{
        
        [detailModel.detailDateArr enumerateObjectsUsingBlock:^(DetailCDModel  *_Nonnull cdModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            cdModel.isChoose = NO;
            
            [detailModel.recordCdModelSelected removeObject:cdModel];
            
        }];
    }
}


//选中section，或者单个选择中row，cell是否已经全部选中
-(void)addModel:(DetailModel *)detailModel JudgeSectionSelectedAll:(NSMutableArray *)recodArr isChoose:(BOOL)isChoose{
    
    BOOL isContain = [recodArr containsObject:detailModel];
    
    if (isChoose) {
        if (!isContain)  [recodArr addObject:detailModel];
    }else{
        if (isContain) [recodArr removeObject:detailModel];
    }

}


/** 计算总价*/
-(void)caculateTotalMoney{
    
   
    // 循环遍历  将所有选中的cell 添加到数组中
    for (DetailModel *detailModel in self.shopCarModel.headModelArr) {
        
        
        [detailModel.detailDateArr enumerateObjectsUsingBlock:^(DetailCDModel  *_Nonnull detailCdModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //所有选中的cell
            if (detailCdModel.isChoose) {
                
                BOOL isContain = [self.selectedCellArr containsObject:detailCdModel];
                
                if (!isContain) [self.selectedCellArr addObject:detailCdModel];
             }
            
        }];
        
    }
    
    NSInteger sum = 0;
    NSInteger value = 0 ;
    
    for (DetailCDModel *detailCdModel  in self.selectedCellArr) {
        value = [detailCdModel.cdPrice integerValue]*[detailCdModel.cdChooseCount integerValue];
        sum = sum+value;
    }
    
    self.totalMoney.text = [NSString stringWithFormat:@"合计:%zd",sum];
    
    if (self.shopCarModel.recordArr.count == self.shopCarModel.headModelArr.count) {
        
        MYLog(@"全选");
        
        [self confirmSelectedAllCell];
        
    }else{
        
        MYLog(@"没有全选");
        
        [self confirmSelectedSingleOrMoreCell];
    }
    
    //
    __weak ViewController *vc = self;
    
    self.deleteSelectedCell = ^{
        

        for (DetailModel *detailModel in vc.shopCarModel.headModelArr) {
            
            [detailModel.detailDateArr removeObjectsInArray:detailModel.recordCdModelSelected];

            //下次刷新之前，移除之前的数据
            [detailModel.recordCdModelSelected removeAllObjects];
        }
        
        [vc.shopCarModel.headModelArr removeObjectsInArray:vc.shopCarModel.recordArr];
        
        //下次刷新之前，移除之前的数据
        [vc.shopCarModel.recordArr removeAllObjects];
        
    };
    

    
}

//点击全选
- (IBAction)selectedAllClick:(UIButton *)sender {
    
    //所有的区数
    NSInteger count =  self.shopCarModel.headModelArr.count;
    
    if (!sender.selected) {
        
        //遍历所有的区头，让区头选中
        for (int i = 0; i<count; i++) {
            
            DetailModel *detailModel = self.shopCarModel.headModelArr[i];
            detailModel.isChoose = NO;
            [self ShoppingCarViewDelegateMethodClickSection:i];
        }
    }
    
    else
    {
        for (int i = 0; i<count; i++) {
            
            DetailModel *detailModel = self.shopCarModel.headModelArr[i];
            detailModel.isChoose = YES;
            [self ShoppingCarViewDelegateMethodClickSection:i];
        }
    }
    [self.tableView reloadData];
}

/** 全选*/
-(void)confirmSelectedAllCell{
    
    [self.selectedAllBtn setTitle:@"取消全选" forState:UIControlStateNormal];
    [self.selectedAllBtn setImage:[UIImage imageNamed:@"color_choose"] forState:UIControlStateNormal];
    self.selectedAllBtn.selected = YES;
}

/** 取消全选*/
-(void)confirmSelectedSingleOrMoreCell{
    
    [self.selectedAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectedAllBtn setImage:[UIImage imageNamed:@"color_no_choose"] forState:UIControlStateNormal];
    self.selectedAllBtn.selected = NO;
}


- (IBAction)delteOrSubmit:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"删除"]) {
        
        if (self.deleteSelectedCell) {
            
            [self loadHudShowLoading];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.deleteSelectedCell();
                
                [self hiddenHud];
                
                [self.tableView reloadData];
                
            });
        }

    }else{
        MYLog(@"结算");
    }
    
    
}


@end
