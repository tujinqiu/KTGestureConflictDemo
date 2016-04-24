//
//  RootTableViewController.m
//  KTGestureConflictDemo
//
//  Created by kevin.tu on 16/4/21.
//  Copyright © 2016年 ovwhkevin0461. All rights reserved.
//

#import "RootTableViewController.h"
#import "KTTableViewCell.h"

@interface RootTableViewController ()

@property (nonatomic, copy) NSArray *colors;
@property (nonatomic, assign) CGFloat height;

@end

@implementation RootTableViewController

static NSString * const reuseIdentifier = @"KTTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[
                    [UIColor grayColor],
                    [UIColor yellowColor],
                    [UIColor redColor]
                    ];
    self.height = [UIScreen mainScreen].bounds.size.height - 64.0;
}

- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configWithColor:[self.colors objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
