//
//  ShoppingViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ShoppingViewController.h"

@interface ShoppingViewController ()
@property (nonatomic,strong) UITextField *texfield; /*<#desc#>*/

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic1 = @{@"query":@"",@"type":@"Same"};
   //接口测试
//    [TCJPHTTPRequestManager POSTWithParameters:dic1 requestID:GetUserId requestcode:kRequestCodequeryclan success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
//            NSLog(@"查询宗亲--%@", jsonDic[@"data"]);
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//    NSDictionary *dic2 = @{@"genid":@"28",@"query":@"",@"pagenum":@"1",@"pagesize":@"20"};
//    [TCJPHTTPRequestManager POSTWithParameters:dic2 requestID:GetUserId requestcode:kRequestCodequeryzbgemelist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
//            NSLog(@"字辈成员--%@", jsonDic[@"data"]);
//        }
//    } failure:^(NSError *error) {
//        
//    }];
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"geid":@"28"} requestID:GetUserId requestcode:kRequestCodequerygeneration success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
             NSLog(@"--%@", [NSString jsonArrWithArr:jsonDic[@"data"]]);
        }
    } failure:^(NSError *error) {
        
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self  action:@selector(getpost) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _texfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 100, 50)];
    _texfield.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:_texfield];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getpost{
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"geid":_texfield.text} requestID:GetUserId requestcode:kRequestCodequerygeneration success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"根据id获取家族信息%@", [NSString jsonArrWithArr:jsonDic[@"data"]]);
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}


@end
