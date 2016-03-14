//
//  FYYCityViewController.m
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "FYYCityGroup.h"
#import "MJExtension.h"
#import "FYYConst.h"
#import "FYYSearchCityResultViewController.h"
#import "UIView+AutoLayout.h"


const int FYYSearchCoverTag = 999;

@interface FYYCityViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *cityGroups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)coverClick;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,  weak) FYYSearchCityResultViewController *searchResultController;

@end

@implementation FYYCityViewController

- (FYYSearchCityResultViewController *)searchResultController
{
    if (!_searchResultController) {
        FYYSearchCityResultViewController *searchResultController = [[FYYSearchCityResultViewController alloc] init];
        [self addChildViewController:searchResultController];
        self.searchResultController = searchResultController;
        
        //将搜索出的结果view加入city的view
        [self.view addSubview:self.searchResultController.view];
        //将搜索结果的view除顶端外全部距离父view0
        [self.searchResultController.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.searchResultController.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:15];
    }
    return _searchResultController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_navigation_close" higImage:@"btn_navigation_close_hl" target:self action:@selector(close)];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    //加载城市数据
    self.cityGroups = [FYYCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    
    self.searchBar.tintColor = FYYColor(32, 191, 179);
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 搜索框代理
/**
 *  键盘弹出：搜索框开始编辑文字
 *
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
//    //2.显示遮盖
//    UIView *cover = [[UIView alloc] init];
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.5;
//    cover.tag = FYYSearchCoverTag;
//    //点击遮盖，遮盖消失
//    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:searchBar action:@selector(resignFirstResponder)]];
//    [self.view addSubview:cover];
//    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView.mas_left);
//        make.right.equalTo(self.tableView.mas_right);
//        make.top.equalTo(self.tableView.mas_top);
//        make.bottom.equalTo(self.tableView.mas_bottom);
//    }];
    
    //2.修改背景图片
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    
        [searchBar setShowsCancelButton:YES animated:YES];
    
    //3.弹出遮盖
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0.5;
    }];
    
}
/**
 *  键盘收回：结束编辑
 *
 *  @param searchBar <#searchBar description#>
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //1.显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
//    //2.隐藏遮盖
//    [[self.view viewWithTag:FYYSearchCoverTag] removeFromSuperview];
    
    //2.修改背景图片
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    
    //隐藏搜索框右边的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    //3.隐藏遮盖
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0;
    }];
    
    //取消后移除搜索结果
    self.searchResultController.view.hidden = YES;
    searchBar.text = nil;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    //或者
//    [self coverClick];
}

/**
 *  搜索框里面文字改变的时候调用
 *
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.searchResultController.view.hidden = NO;
        self.searchResultController.cityResult = searchText;
    } else {
        self.searchResultController.view.hidden = YES;
    }


}

/**
 *  点击遮盖消失
 */
- (IBAction)coverClick {
    [self.searchBar resignFirstResponder];
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    FYYCityGroup *cityGroup =  self.cityGroups[section];
    return cityGroup.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"city";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    FYYCityGroup *cityGroup = self.cityGroups[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    return cell;
}


#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FYYCityGroup *group = self.cityGroups[section];
    return group.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.cityGroups valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYYCityGroup * group= self.cityGroups[indexPath.section];
    //发出通知
    [FYYNotificationCenter postNotificationName:FYYCityDidSelectNotification object:nil userInfo:@{FYYSelectCityName : group.cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
