//
//  WPFHomeVC.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFHomeVC.h"
#import "WPFStatusCell.h"
#import "WPFAccount.h"
#import "WPFHomeTitleView.h"
#import "WPFHomeCoverView.h"
#import "WPFHttpTool.h"
#import "WPFStatusRequest.h"
#import "WPFStatus.h"
#import "MJExtension.h"
#import "WPFHomeFooterView.h"
#import "WPFStatusFrame.h"
#import "WPFStatusDetailViewController.h"


@interface WPFHomeVC ()<WPFHomeCoverViewDelegate>

@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) UIRefreshControl *refresh;
@property (nonatomic, weak) UILabel *lab;
@property (nonatomic, weak) WPFHomeFooterView *footerView;
@end

@implementation WPFHomeVC

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupRefresh];
    
    [self setupNewStatusLab];
    
    [self setupFooterView];


}
#pragma mark - 添加控件

- (void)setupFooterView
{
    WPFHomeFooterView *view = [[WPFHomeFooterView alloc] init];
    self.tableView.tableFooterView = view;
    self.footerView = view;
}
- (void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];
    self.refresh = refresh;
    
    // 更新下数据
    [refresh beginRefreshing];
    [self loadNewStatus:refresh];
    
}

- (void)setupNewStatusLab
{
    UILabel *lab = [[UILabel alloc] init];
    CGFloat w = self.view.width;
    CGFloat h = 30;
    CGFloat x = 0;
    CGFloat y = 64 - h;
    lab.frame = CGRectMake(x, y, w, h);
    
    lab.backgroundColor = [UIColor orangeColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15.0];
    lab.textColor = [UIColor blackColor];
    lab.alpha = 0.0;
    
    [self.navigationController.view insertSubview:lab belowSubview:self.navigationController.navigationBar];
    
    self.lab = lab;

}

- (void)setupNavigationBar
{
    // 自带的item不能实现高亮状态图片  需要自定义
    UIBarButtonItem *leftitem = [UIBarButtonItem itemWithBackgroundImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(rightItemOnClick:)];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    UIBarButtonItem *rightitem = [UIBarButtonItem itemWithBackgroundImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(rightItemOnClick:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    WPFHomeTitleView *btn = [WPFHomeTitleView buttonWithType:UIButtonTypeCustom];
    btn.height = 35;
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    NSString *name = [WPFAccount account].screen_name;
    name = name ? name : @"首页";
    [btn setTitle:name forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(titleViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}

#pragma mark - 下拉刷新

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WPFStatus *status in statuses) {
        WPFStatusFrame *frame = [[WPFStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

- (void)loadNewStatus:(UIRefreshControl *)refresh
{
    WPFStatusRequest *params = [[WPFStatusRequest alloc] init];
    params.access_token = [WPFAccount account].access_token;
    WPFStatusFrame *statusFrames = [self.statusFrames firstObject];
    if (statusFrames) {
        params.since_id = @([statusFrames.status.idstr longLongValue]);
    }
    
    [WPFHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responsObj) {
        
        NSArray *arrStatus = [WPFStatus objectArrayWithKeyValuesArray:responsObj[@"statuses"]];
        NSArray *frames = [self statusFramesWithStatuses:arrStatus];
        
        NSRange rang = NSMakeRange(0, arrStatus.count);
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:rang];
        [self.statusFrames insertObjects:frames atIndexes:indexSet];
        [self.refresh endRefreshing];
        [self.tableView reloadData];
        [self showNewStatusCount:frames.count];
        
    } failure:^(NSError *error) {
        WPFLog(@"WPFStatusRequest");
        [self.refresh endRefreshing];
        
    }];
}

- (void)showNewStatusCount:(int)count
{
    // 每次都会创建一个
    NSString *text = nil;
    if (count) {
        text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }else{
        text = @"没有最新的微博数据";
    }
    self.lab.text = text;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.lab.transform = CGAffineTransformMakeTranslation(0,self.lab.height);
        self.lab.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.lab.transform = CGAffineTransformIdentity;
            self.lab.alpha = 0.0;
        } completion:nil];
        
    }];
}

#pragma mark - 加载更多
- (void)loadMoreStatus
{
    WPFStatusRequest *params = [[WPFStatusRequest alloc] init];
    params.access_token = [WPFAccount account].access_token;
    WPFStatusFrame *statusFrames = [self.statusFrames lastObject];
    if (statusFrames) {
        params.max_id = @([statusFrames.status.idstr longLongValue]);
    }
    
    [WPFHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responsObj) {
        NSArray *arrStatus = [WPFStatus objectArrayWithKeyValuesArray:responsObj[@"statuses"]];
        NSArray *frams = [self statusFramesWithStatuses:arrStatus];
        
        [self.statusFrames addObjectsFromArray:frams];
        [self.tableView reloadData];
        [self.footerView stopAnimation];
    } failure:^(NSError *error) {
        WPFLog(@"loadMoreStatus");
    }];
}

#pragma mark - 点击导航栏按钮
- (void)titleViewOnClick:(UIButton *)btn
{
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    WPFHomeCoverView *coverView = [[WPFHomeCoverView alloc] init];
    coverView.delegate = self;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [coverView addContentView:addBtn];
    [coverView showInRect:CGRectMake(100, 100, 100, 100)];
    
}
- (void)rightItemOnClick:(UIButton *)btn
{
    WPFLog(@"rightItemOnClick");
}
- (void)leftItemOnClick:(UIButton *)btn
{
    WPFLog(@"leftItemOnClick");
}

#pragma mark - WPFHomeCoverViewDelegate
- (void)coverView:(WPFHomeCoverView *)coverView OnClick:(UIButton *)btn
{
    WPFHomeTitleView *titleView = (WPFHomeTitleView *)self.navigationItem.titleView;
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footerView.hidden = !self.statusFrames.count;
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WPFStatusCell *cell = [WPFStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

#pragma mark - Table view data delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 没有这句话的时候在启动的 时候就会加载多次
    if (self.statusFrames.count <= 0 || self.footerView.isrefreshing) return;
    
    // 当看到剩下这么高的时候改变
    CGFloat sawHeight = self.view.height - self.tabBarController.tabBar.height - self.tableView.tableFooterView.height;
    
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    
    if (delta <= sawHeight) {
        [self.footerView startAnimation];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadMoreStatus];
        });
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrames[indexPath.row] height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPFStatusDetailViewController *detail = [[WPFStatusDetailViewController alloc] init];
    WPFStatusFrame *frame = self.statusFrames[indexPath.row];
    detail.status = frame.status;
    [self.navigationController pushViewController:detail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
