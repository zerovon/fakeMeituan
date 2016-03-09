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

@interface FYYHomeViewController ()

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
    
    // 设置导航栏内容
    [self setUpLeftNav];
    [self setUpRightNav];
}

#pragma mark - 设置导航栏内容
- (void) setUpLeftNav
{
    //LOGO
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logo.enabled = NO;
    
    
    //2.类别
    FYYHeaderItem *categoryItem = [FYYHeaderItem item];
    [categoryItem addTarget:self action:@selector(categoryClick)];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithCustomView:categoryItem];
    
    //3.地区
    FYYHeaderItem *districtItem = [FYYHeaderItem item];
    [districtItem addTarget:self action:@selector(districtClick)];
    UIBarButtonItem *districtIt = [[UIBarButtonItem alloc] initWithCustomView:districtItem];
    
    //2.排序
    FYYHeaderItem *sortItem = [FYYHeaderItem item];
    [sortItem addTarget:self action:@selector(sortClick)];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithCustomView:sortItem];
    
    self.navigationItem.leftBarButtonItems = @[logo, category, districtIt, sort];
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
    
}

- (void) districtClick
{
    
}

- (void) sortClick
{
    
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

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
