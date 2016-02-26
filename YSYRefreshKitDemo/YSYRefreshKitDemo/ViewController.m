//
//  ViewController.m
//  YSYRefreshKitDemo
//
//  Created by shengyang_yu on 16/2/23.
//  Copyright © 2016年 yushengyang. All rights reserved.
//

#import "ViewController.h"
#import "YSYRefreshKit.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) YSYRefreshKit *mShowHead;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mTable.rowHeight = 64.0f;
//    self.mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.mTable.scrollEnabled = NO;
    [self.mTable registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // refresh head
    self.mShowHead = [[YSYRefreshKit alloc] initWithSuperView:self.view withScrollView:self.mTable];
    self.mShowHead.mStatusHeight = -20;
    __weak __typeof(self)weakSelf = self;
    self.mShowHead.startBlock = ^() {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.mShowHead endRefresh];
        });
    };
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.text = [NSString stringWithFormat:@"textLabel:%@",@(indexPath.row)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
