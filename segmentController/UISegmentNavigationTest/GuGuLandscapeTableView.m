//
//  GuGuLandscapeTableView.m
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import "GuGuLandscapeTableView.h"

@implementation GuGuLandscapeTableView
@synthesize cellDataSource;
@synthesize swipeDelegate;
- (id)initWithFrame:(CGRect)frame Array:(NSArray*)array
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
//        NSLog(@"%@",NSStringFromCGRect(frame));
//        self.backgroundColor = [UIColor redColor];
        tableView = [[UITableView alloc]initWithFrame:self.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollsToTop = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //缺少这个会引起XY坐标轴的变化
//        NSLog(@"tableView.frame--->%@",NSStringFromCGRect(tableView.frame));
        tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
//        NSLog(@"tableView.frame--->%@",NSStringFromCGRect(tableView.frame));
        tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        tableView.showsVerticalScrollIndicator = NO;
        tableView.pagingEnabled = YES;
//        tableView.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1.0];
        tableView.bounces =YES;//弹簧效果
        [self addSubview:tableView];
         self.cellDataSource = array;
        
    }
    return self;
}


- (void)reloadTableWithArray:(NSArray*)array
{
    if (array && array.count >0)
    {
        self.cellDataSource = array;
        [tableView reloadData];
    }
}
#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{//此时的XY轴已经变化了 所以这个传的是宽
//    int a = self.frame.size.width;
    return self.frame.size.width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = self.cellDataSource.count;
    
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ViewCell";
    
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        UIViewController *vc = [cellDataSource objectAtIndex:[indexPath row]];
//        NSLog(@"cell.bounds--->%@",NSStringFromCGRect(cell.bounds));
//        NSLog(@"cell.contentView--->%@==",NSStringFromCGRect(cell.contentView.frame));
        vc.view.frame = cell.bounds;
//        NSLog(@"vc.view.frame--->%@",NSStringFromCGRect(vc.view.frame));
        [cell.contentView addSubview:vc.view];
    }
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.swipeDelegate != nil && [self.swipeDelegate respondsToSelector:@selector(contentSelectedIndexChanged:)])
    {
        int index = tableView.contentOffset.y / self.frame.size.width;
        [self.swipeDelegate contentSelectedIndexChanged:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pt =   tableView.contentOffset;
    [self.swipeDelegate scrollOffsetChanged:pt];
}

-(void)selectIndex:(int)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    
}
@end
