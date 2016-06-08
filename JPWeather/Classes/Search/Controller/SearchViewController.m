//
//  SearchViewController.m
//  JPWeather
//
//  Created by Jimmy on 15/11/18.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "SearchViewController.h"
#import "FWBSearchBar.h"
#import "ExitCityCell.h"
#import "SearchCell.h"
#import "City.h"
#import "Weather.h"
#import "DataSpreadTool.h"
#import "ActivityIndicator.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTabelView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) ActivityIndicator *activity;
@property (nonatomic, strong) NSMutableDictionary *exitCity;
@property (weak, nonatomic) IBOutlet UICollectionView *exitCityView;
@property (strong, nonatomic) NSMutableDictionary *weathers;
@property (nonatomic, strong) NSArray *fliterArray;


@end
static DataSpreadTool *tool = nil;
@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _activity = [ActivityIndicator new];
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
    [self.view bringSubviewToFront:_activity];
    [_activity hidden];
    [self getAllCityData];

    [self setUpSearchBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.exitCityView.hidden = NO;
    [self getAllCityData];
    [self.exitCityView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_activity hidden];
}
#pragma mark - 得到所有城市
- (void)getAllCityData
{
    _exitCity = [City findAllCity];
    _weathers = [[DataSpreadTool alloc] dataForFutureWeather];

}
#pragma mark - 设置搜索框
- (void)setUpSearchBar
{
    _searchBar.placeholder = @"请输入城市";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;

}
#pragma mark - searchbar代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    _fliterArray = [self.exitCity.allKeys filteredArrayUsingPredicate:predicate];
    if (_fliterArray.count != 0) {
        [_searchTabelView reloadData];
    }
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.exitCityView.hidden = YES;
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setText:@""];
    self.searchTabelView.hidden = YES;
    self.exitCityView.hidden = NO;
    [_searchBar resignFirstResponder];
}
#pragma mark - tableviewdatasource代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_searchBar.text isEqualToString:@""]) {
        self.searchTabelView.hidden = YES;
        return _exitCity.count;
    }else{
        self.searchTabelView.hidden = NO;
        return _fliterArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.cityLabel.text = _fliterArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_activity showWithText:@"Loading...."];
    NSString *cityName = [_fliterArray objectAtIndex:indexPath.row];
    DataSpreadTool *tool = [[DataSpreadTool alloc]init];
    [tool addWeatherByCityName:cityName];
    [_cellDelegate changeUIWithName:cityName];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -UICollectionViewDataSource代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_weathers.allKeys.count <= 6) {
        return _weathers.allKeys.count;
    }else{
        return 6;
    }
//    return _weathers.allKeys.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExitCityCell *cell = [ExitCityCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    cell.cityName.text = [[_weathers.allKeys sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.row];
    Weather *weather = [[Weather alloc] initWithDictionary:[_weathers[cell.cityName.text][@"result"] objectAtIndex:indexPath.row]];
    tool = [DataSpreadTool new];
    cell.weatherIcon.image = [tool getIconByWeather:weather];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=200+(arc4random()%100);
    return  CGSizeMake(100, height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExitCityCell *cell = (ExitCityCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *cityName = cell.cityName.text;
    tool = [[DataSpreadTool alloc]init];
    [self getAllCityData];
    [_cellDelegate changeUIWithName:cityName];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
