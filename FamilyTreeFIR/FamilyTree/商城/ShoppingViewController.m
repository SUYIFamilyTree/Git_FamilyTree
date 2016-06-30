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

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Ceshi];
    
    MYLog(@"%@",[NSString md5Str:@"/abc"]);
    
}

-(void)Ceshi{
    UIImage *list =[UIImage imageNamed:@"ci_sm@3x"];
    NSData *imageData = UIImageJPEGRepresentation(list, 0.5);
    NSString *encodeimageStr =[imageData base64Encoding];
    NSLog(@"%@",encodeimageStr);
    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)encodeimageStr,NULL,CFSTR(":/?#[]@!$&’()*+,;="),kCFStringEncodingUTF8);
    //    NSLog(@"%@",baseString);
    //    NSString *imgStr =[baseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *params =@{@"userid":GetUserId,@"imgbt":@"/abc"};
    [TCJPHTTPRequestManager POSTWithParameters:params requestID:GetUserId requestcode:@"uploadmemimg" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = [NSDictionary DicWithString:jsonDic[@"data"]];
            NSLog(@"%@", dic);
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
