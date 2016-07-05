//
//  ShoppingViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ShoppingViewController.h"
#import "NSString+md5.h"

@interface ShoppingViewController ()
@property (nonatomic,strong) UITextField *texfield; /*<#desc#>*/

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试上传图片
    //[self Ceshi];
    //测试墓园列表
    //[self ceshiMuyuanList];
    
    //测试墓园详情
    //[self ceshiMuyuanInfo];
    
    //测试添加墓园
    //[self ceshiTianjiamuyuan];
    //MYLog(@"%@",[NSString md5Str:@"/abc"]);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self  action:@selector(getpost) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _texfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 100, 50)];
    _texfield.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:_texfield];
    
}

-(void)Ceshi{
    UIImage *list =[UIImage imageNamed:@"ci_sm@3x"];
    NSData *imageData = UIImageJPEGRepresentation(list, 0.5);
    NSString *encodeimageStr =[imageData base64EncodedString];
    NSDictionary *params =@{@"userid":GetUserId,@"imgbt":encodeimageStr};
    [TCJPHTTPRequestManager POSTWithParameters:params requestID:GetUserId requestcode:@"uploadmemimg" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = [NSDictionary DicWithString:jsonDic[@"data"]];
            NSLog(@"%@", dic);
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)ceshiMuyuanList{
//    NSDictionary *logDic = @{@"pagenum":@2,@"pagesize":@2,@"meid":@"15",@"type":@"PRI"};
    NSDictionary *logDic = @{@"pagenum":@2,@"pagesize":@2,@"meid":@"",@"type":@"PRI"};
    
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"cemeterylist" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"墓园列表%@",jsonDic[@"message"]);
        MYLog(@"墓园列表%@",jsonDic[@"data"]);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];

}

-(void)ceshiMuyuanInfo{
    NSDictionary *logDic = @{@"CeId":@"1"};
    
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"cemeterdetail" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"墓园详情%@",jsonDic[@"message"]);
        MYLog(@"墓园详情%@",jsonDic[@"data"]);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];

}

-(void)ceshiTianjiamuyuan{
    NSDictionary *logDic = @{@"CeId":@"1"};
    
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"cemeterdetail" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"墓园详情%@",jsonDic[@"message"]);
        MYLog(@"墓园详情%@",jsonDic[@"data"]);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];

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
