//
//  FYYSearchCityResultViewController.m
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYSearchCityResultViewController.h"
#import "MJExtension.h"
#import "FYYCity.h"
#import "FYYConst.h"
#import "FYYMetaUtil.h"

@interface FYYSearchCityResultViewController ()

@property (nonatomic, strong) NSMutableArray *cityResultArray;

@end

@implementation FYYSearchCityResultViewController

- (void)setCityResult:(NSString *)cityResult
{
    _cityResult = [cityResult copy];
    self.cityResultArray = [NSMutableArray array];
    cityResult = cityResult.lowercaseString;
    
    //根据关键字搜索城市 第一种方法
//    for(FYYCity *city in self.cities) {
//        if ([city.name containsString:cityResult ] || [city.pinYin.uppercaseString containsString:cityResult.uppercaseString ] || [city.pinYinHead.uppercaseString containsString: cityResult.uppercaseString]) {
//            [self.cityResultArray addObject:city];
//        }
//    }
//    
    //第二种方法：谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@", cityResult, cityResult, cityResult];
    self.cityResultArray = [[FYYMetaUtil cities] filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.cityResultArray.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cityResult";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    FYYCity *city =  self.cityResultArray[indexPath.row];
    cell.textLabel.text =city.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%d条查询结果", self.cityResultArray.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYYCity *city =  self.cityResultArray[indexPath.row];
    [FYYNotificationCenter postNotificationName:FYYCityDidSelectNotification object:nil userInfo:@{FYYSelectCityName : city.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
