//
//  FYYHomeViewController.m
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYHomeViewController.h"
#import "FYYConst.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Frame.h"
#import "FYYHeaderItem.h"
#import "FYYCategoryViewController.h"
#import "FYYDistrictViewController.h"
#import "FYYMetaUtil.h"
#import "FYYCity.h"
#import "FYYSortViewController.h"
#import "FYYSort.h"
#import "FYYCategory.h"
#import "FYYRegion.h"
#import "DPAPI.h"

@interface FYYHomeViewController () <DPRequestDelegate>
//分类item
@property (nonatomic, weak) UIBarButtonItem *categoryItem;

//地区item
@property (nonatomic, weak) UIBarButtonItem *districtItem;

//排序item
@property (nonatomic, weak) UIBarButtonItem *sortItem;

//当前导航栏上显示的城市
@property (nonatomic, copy) NSString *selectedCityName;

//导航栏的popover
@property (nonatomic, strong) UIPopoverController *sortPop;
@property (nonatomic, strong) UIPopoverController *distrcitPop;
@property (nonatomic, strong) UIPopoverController *categoryPop;

@end

@implementation FYYHomeViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype) init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景色
    self.collectionView.backgroundColor = FYYGlobalBg;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //监听城市改变
    [FYYNotificationCenter addObserver:self selector:@selector(cityChage:) name:FYYCityDidSelectNotification object:nil];
    
    //监听排序改变
    [FYYNotificationCenter addObserver:self selector:@selector(sortChage:) name:FYYSortDidChageNotification object:nil];
    
    //监听分类改变
    [FYYNotificationCenter addObserver:self selector:@selector(catChage:) name:FYYCategoryDidChageNotification object:nil];
    
    //监听区域改变
    [FYYNotificationCenter addObserver:self selector:@selector(districtChage:) name:FYYDistrictDidChageNotification object:nil];
    
    // 设置导航栏内容
    [self setUpLeftNav];
    [self setUpRightNav];
}

-(void)dealloc
{
    [FYYNotificationCenter removeObserver:self];
}

#pragma mark -监听通知 
- (void)districtChage:(NSNotification *)notification {
    FYYRegion *region = notification.userInfo[FYYSelectDistrict];
    NSString *subRegionName = notification.userInfo[FYYSelectSubDistrict];
    
    FYYHeaderItem *headerCatView = (FYYHeaderItem *)self.districtItem.customView;
    [headerCatView setTitle:[NSString stringWithFormat:@"%@ - %@",self.selectedCityName, region.name]];
    [headerCatView setSubTitle:notification.userInfo[FYYSelectSubDistrict] ? notification.userInfo[FYYSelectSubDistrict] : @"全部"];
    
    //关闭popover
    [self.distrcitPop dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

- (void)cityChage: (NSNotification *) notification {
    NSString *cityName = notification.userInfo[FYYSelectCityName];
    self.selectedCityName = cityName;
    //更换nav顶部城市的名字
    FYYHeaderItem *distrct = (FYYHeaderItem *)self.districtItem.customView;
    [distrct setTitle:[NSString stringWithFormat:@"%@ － 全部", cityName]];
    [distrct setSubTitle:nil];

    
    //刷新表格数据
    [self loadNewDeals];
}

- (void)sortChage:(NSNotification *)notification
{
    //更新顶部排序栏的文字
    FYYSort *sort = notification.userInfo[FYYSelectSort];
    FYYHeaderItem *headerSortView = (FYYHeaderItem *)self.sortItem.customView;
    [headerSortView setSubTitle:sort.label];
    
    //关闭popover
    [self.sortPop dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

- (void)catChage:(NSNotification *)notification
{
    FYYCategory *category = notification.userInfo[FYYSelectCategory];
    FYYHeaderItem *headerCatView = (FYYHeaderItem *)self.categoryItem.customView;
    [headerCatView setTitle:category.name];
    [headerCatView setSubTitle:notification.userInfo[FYYSelectSubCategory] ? notification.userInfo[FYYSelectSubCategory] : @"全部"];
    [headerCatView setIcon:category.icon highLightIcon:category.highlighted_icon];
    
    //关闭popover
    [self.categoryPop dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

#pragma mark - 跟服务器交互
- (void)loadNewDeals {
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.selectedCityName;
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"%@", result);
}


#pragma mark - 设置导航栏内容
- (void) setUpLeftNav
{
    //LOGO
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logoItem.enabled = NO;
    
    
    //2.类别  FYYHeaderItem是一个用来封装xib的view
    FYYHeaderItem *categoryView = [FYYHeaderItem item];
    [categoryView addTarget:self action:@selector(categoryClick)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    
    //3.地区
    FYYHeaderItem *districtView = [FYYHeaderItem item];
    [districtView addTarget:self action:@selector(districtClick)];
    UIBarButtonItem *districtItItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    self.districtItem = districtItItem;
    
    //2.排序
    FYYHeaderItem *sortView = [FYYHeaderItem item];
    [sortView setTitle:@"排序"];
    [sortView setIcon:@"icon_sort" highLightIcon:@"icon_sort_highlighted"];
    [sortView addTarget:self action:@selector(sortClick)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];
    self.sortItem = sortItem;
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, districtItItem, sortItem];
}

#pragma mark - 导航栏右侧
- (void)setUpRightNav
{
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithImage:@"icon_map" higImage:@"icon_map_highlighted" target:nil action:nil];
    mapItem.customView.width = 80;
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImage:@"icon_search" higImage:@"icon_search_highlighted" target:nil action:nil];
    searchItem.customView.width = 80;
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
}

#pragma mark - 顶部item点击方法
- (void) categoryClick
{
    self.categoryPop = [[UIPopoverController alloc] initWithContentViewController:[[FYYCategoryViewController alloc] init]];
    [self.categoryPop presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void) districtClick
{
    FYYDistrictViewController *district= [[FYYDistrictViewController alloc] init];
    //根据城市名找城市区域
    if (self.selectedCityName) {
        FYYCity *city =  [[[FYYMetaUtil cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.selectedCityName]] firstObject];
        district.regions = city.regions;
    }
    self.distrcitPop = [[UIPopoverController alloc] initWithContentViewController:district];
    [self.distrcitPop presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    district.popover = self.distrcitPop;
}

- (void) sortClick
{
    FYYSortViewController *sortVc = [[FYYSortViewController alloc] init];
    self.sortPop= [[UIPopoverController alloc] initWithContentViewController:sortVc];
    [self.sortPop presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
