//
//  MyOrdersViewController.m
//  ListV
//
//  Created by imac on 16/8/1.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "OrderStatusView.h"
#import "ShopOrdersCell.h"
#import "ShopGoodModel.h"


@interface MyOrdersViewController ()<OrderStatusViewDelegate,UITableViewDelegate,UITableViewDataSource,ShopOrdersCellDelegate>
/**
 *  订单状态
 */
@property (strong,nonatomic) OrderStatusView *orderStatusV;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation MyOrdersViewController

- (void)getData{
    _dataArr = [NSMutableArray array];
    NSArray *statusArr = @[@"待付款",@"交易关闭",@"买家已付款",@"卖家已发货",@"交易成功"];
    for (int i= 0; i<5; i++) {
        switch (i) {
            case 0:{
                ShopGoodModel *order = [[ShopGoodModel alloc]init];
                order.date = @"2016-03-05";
                order.status = statusArr[i];
                order.goodArr = [NSMutableArray array];
                GoodCarModel *good = [[GoodCarModel alloc]init];
                good.goodName = @"黑曜石手链阿弥陀佛虚空藏文殊大日如来菩萨女男手串";
                good.orderNo = @"20160221156";
                good.goodMoney = @"589";
                good.goodQuote = @"889";
                good.goodcount = @"1";
                [order.goodArr addObject:good];
                order.totalCount = @"1";
                order.totalMoney = @"589.00";
                order.freight = @"0.0";
                [_dataArr addObject:order];
            }
                break;
            case 1:{
                ShopGoodModel *order = [[ShopGoodModel alloc]init];
                order.date = @"2016-03-05";
                order.status = statusArr[i];
                order.goodArr = [NSMutableArray array];
                GoodCarModel *good = [[GoodCarModel alloc]init];
                good.goodName = @"黑曜石手链阿弥陀佛虚空藏文殊大日如来菩萨女男手串";
                good.orderNo = @"20160221156";
                good.goodMoney = @"88";
                good.goodQuote = @"128";
                good.goodcount = @"2";
                [order.goodArr addObject:good];
                order.totalCount = @"2";
                order.totalMoney = @"176.00";
                order.freight = @"0.0";
                [_dataArr addObject:order];
            }
                break;
            case 2:{
                ShopGoodModel *order = [[ShopGoodModel alloc]init];
                order.date = @"2016-03-05";
                order.status = statusArr[i];
                order.goodArr = [NSMutableArray array];
                GoodCarModel *good = [[GoodCarModel alloc]init];
                good.goodName = @"黑曜石手链阿弥陀佛虚空藏文殊大日如来菩萨女男手串";
                good.orderNo = @"20160221156";
                good.goodMoney = @"278";
                good.goodQuote = @"328";
                good.goodcount = @"1";
                [order.goodArr addObject:good];
                order.totalCount = @"1";
                order.totalMoney = @"278.00";
                order.freight = @"0.0";
                [_dataArr addObject:order];
            }
                break;
            case 3:{
                ShopGoodModel *order = [[ShopGoodModel alloc]init];
                order.date = @"2016-03-05";
                order.status = statusArr[i];
                order.goodArr = [NSMutableArray array];
                for ( int i=0; i<2; i++) {
                    GoodCarModel *good = [[GoodCarModel alloc]init];
                    good.goodName = @"黑曜石手链阿弥陀佛虚空藏文殊大日如来菩萨女男手串";
                    good.orderNo = @"20160221156";
                    good.goodMoney = @"278";
                    good.goodQuote = @"328";
                    good.goodcount = @"1";
                    [order.goodArr addObject:good];
                }
                 order.totalCount = @"2";
                 order.totalMoney = @"556.00";
                 order.freight = @"0.0";
                  [_dataArr addObject:order];
            }
                break;
            case 4:{
                ShopGoodModel *order = [[ShopGoodModel alloc]init];
                order.date = @"2016-03-05";
                order.status = statusArr[i];
                order.goodArr = [NSMutableArray array];
                GoodCarModel *good = [[GoodCarModel alloc]init];
                good.goodName = @"黑曜石手链阿弥陀佛虚空藏文殊大日如来菩萨女男手串";
                good.orderNo = @"20160221156";
                good.goodMoney = @"278";
                good.goodQuote = @"328";
                good.goodcount = @"1";
                [order.goodArr addObject:good];
                order.totalCount = @"1";
                order.totalMoney = @"278.00";
                order.freight = @"0.0";
                [_dataArr addObject:order];
            }
                break;
            default:
                break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self getData];
    [self initView];
    self.view.backgroundColor = LH_RGBCOLOR(230, 230, 230);

}

- (void)initView{
    NSArray *typeArr = @[@"全部",@"待付款",@"待收货",@"待评价"];
    _orderStatusV = [[OrderStatusView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 40)];
    [self.view addSubview:_orderStatusV];
    [_orderStatusV initTypeArr:typeArr];
    _orderStatusV.delegate = self;

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_orderStatusV), __kWidth, __kHeight-104)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = LH_RGBCOLOR(230, 230, 230);
    _tableView.delegate = self;
    _tableView.dataSource = self;

}

#pragma mark -UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ShopOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopOrdersCell"];
    ShopOrdersCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ShopOrdersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopOrdersCell"];
    }
    cell.delegate = self;
    ShopGoodModel *order = _dataArr[indexPath.row];
    cell.dateLb.text = order.date;
    cell.statusLb.text = order.status;
    cell.totalLb.text = [NSString stringWithFormat:@"共%@件",order.totalCount];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"应付金额:¥%@(含运费¥%@)",order.totalMoney,order.freight]];
    NSRange redrange = NSMakeRange(5, order.totalMoney.length+1);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redrange];
    [cell.allPayLb setAttributedText:noteStr];
    [cell initShopView:order];
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopGoodModel *order = _dataArr[indexPath.row];
    CGFloat height = __kWidth/4*order.goodArr.count+120;
    NSLog(@"%f",height);
    return height;
}
#pragma mark ==点击cell==
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopGoodModel *order = _dataArr[indexPath.row];
    for (GoodCarModel *good  in order.goodArr) {
        NSLog(@"%@\n%@\n%@",good.goodName,good.goodMoney,good.goodcount);
    }

}
- (void)orderAction:(NSString *)order action:(UIButton *)sender{
    NSLog(@"%@订单%@",sender.titleLabel.text,order);
}

#pragma mark ==更换订单数据==
-(void)orderTypeChoose:(UIButton *)sender{
    NSLog(@"%@",sender.titleLabel.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
