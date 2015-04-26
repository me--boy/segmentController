//
//  GuGuLandscapeTableView.h
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuGuSegmentBarView.h"


@interface GuGuLandscapeTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
}
/**
 *  存放所有的viewController的数组
 */
@property(nonatomic,retain)NSArray *cellDataSource;

- (void)reloadTableWithArray:(NSArray*)array;
- (id)initWithFrame:(CGRect)frame Array:(NSArray*)array;
-(void)selectIndex:(int)index;

@property(nonatomic,unsafe_unretained)id<GuGuIndexDelegate>swipeDelegate;
@end
