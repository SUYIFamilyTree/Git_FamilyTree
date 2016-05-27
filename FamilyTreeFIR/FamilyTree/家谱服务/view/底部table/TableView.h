//
//  TableView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/26.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableView;

@protocol TableViewDelegate <NSObject>

-(void)tableView:(TableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface TableView : UIView
@property (nonatomic,weak) id<TableViewDelegate> delegate; /*代理人*/

@end
