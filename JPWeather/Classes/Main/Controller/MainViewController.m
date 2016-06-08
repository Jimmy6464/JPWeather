//
//  MainViewController.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "InfoCell.h"
#import "SearchViewController.h"
#import "ActivityIndicator.h"

#import "MyView.h"
#import "CurrentWeather.h"
#import "Weather.h"
#import "RootTool.h"
#import "NetWorkTool.h"

#import "ProtocolDataSpread.h"
#import "DataSpreadTool.h"



@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,ButtonOperation,ChangeAndLocatedToTheCell,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *futureWeatherView;
@property (weak, nonatomic) IBOutlet UICollectionView *infoView;
@property (strong, nonatomic) ActivityIndicator *activity;
/*
 播放控制器
 */
@property (strong, nonatomic) MPMoviePlayerController *player;
/*
 定位管理者
 */
@property (strong, nonatomic) CLLocationManager *locationManager;
/*
 分页点
 */
@property (strong, nonatomic) UIPageControl *pageControl;
/*
 已存在的城市的即时天气数据数组
 */
@property (strong, nonatomic) NSMutableDictionary *exitCity_currentWeather;
/*
 已存在的城市的未来天气数据数组
 */
@property (strong, nonatomic) NSMutableDictionary *exitCity_futureWeather;
/*
 存在城市
 */
@property (strong, nonatomic) NSArray *cityKeys;
/*
 数据传递者
 */
@property (strong, nonatomic) id<ProtocolDataSpread> dataDelegate;

- (IBAction)addCity:(id)sender;
- (IBAction)locatedPressed:(id)sender;

@end
static NSIndexPath *_indexPath;
static NSString *currentPlace;
DataSpreadTool *_tool = nil;
@implementation MainViewController
#pragma mark - 系统方法
- (void)loadView
{
    [super loadView];
    [self getDataFromDelegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.设置infoView
    [self setUpInfoView];
    
    //2.设置播放器
    [self setUpPlayer];

    //3.设置分页
    [self setUpPageControl];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //拿数据
    [self getDataFromDelegate];
    [self.infoView reloadData];
}

#pragma mark - 设置分页
- (void)setUpPageControl
{
    UIPageControl *page = [[UIPageControl alloc] init];
    page.frame = CGRectMake(page.frame.origin.x, page.frame.origin.y, 300, 40);
    page.center = CGPointMake(self.view.center.x, self.view.frame.size.height-130);
    page.numberOfPages = _cityKeys.count;
    page.currentPageIndicatorTintColor = [UIColor whiteColor];
    page.pageIndicatorTintColor = [UIColor grayColor];
    [page addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    _pageControl = page;
    [self.view addSubview:page];
    [self.view bringSubviewToFront:page];
    _activity = [[ActivityIndicator alloc]init];
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
    [self.view bringSubviewToFront:_activity];
    [_activity hidden];
}
- (void)pageControlAction:(UIPageControl *)page
{
    [_infoView setContentOffset:CGPointMake(375*page.currentPage, 0)];
}
//设置同步page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width +0.5;
    _pageControl.currentPage = page;
}
#pragma mark - 设置未来天气视图
- (void)setUpFutureWeatherView
{
    if (_futureWeatherView.subviews.count != 0) {
        for (UIView *view in _futureWeatherView.subviews) {
            [view removeFromSuperview];
        }
    }
    NSArray *array;
    if (_cityKeys.count < _indexPath.row+1) {
        array = _exitCity_futureWeather[_cityKeys[_indexPath.row-1]][@"result"];
    }else{
        array = _exitCity_futureWeather[_cityKeys[_indexPath.row]][@"result"];
    }
    _futureWeatherView.contentSize = CGSizeMake(127*array.count, 121);
    _futureWeatherView.pagingEnabled = YES;
    _futureWeatherView.showsHorizontalScrollIndicator = NO;
    _futureWeatherView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        Weather *weather = [[Weather alloc]initWithDictionary:dict];
        MyView *view = [[MyView alloc]initWithFrame:CGRectMake(0+i*127, 0, 127, 130) withData:weather];
        [_futureWeatherView addSubview:view];
    }

}
#pragma mark - 设置播放器
- (void)setUpPlayer
{
    _player = [[MPMoviePlayerController alloc]init];
    _player.controlStyle = MPMovieControlStyleNone;
    _player.shouldAutoplay = YES;//自动播放
    _player.scalingMode = MPMovieScalingModeFill;//视频缩放
    _player.view.frame = CGRectMake(0, 0, 375, 667);
    [self.view addSubview:_player.view];
    [self bringAllSubViewTofront];
}
- (void)playBackDidFinish:(id)sender
{
    [_player prepareToPlay];
    [_player play];
}

- (void)playVideo
{
    NSArray *array = _exitCity_futureWeather[_cityKeys[_indexPath.row]][@"result"];
    NSDictionary *dict = [array objectAtIndex:0];
    Weather *weather = [[Weather alloc]initWithDictionary:dict];
    NSString *video = [_tool changeWeatherBacugroundByWeather:weather];
    //本地文件
    NSString *path = [[NSBundle mainBundle] pathForResource:video ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _player.contentURL = url;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [_player prepareToPlay];
    [_player play];
    
}

#pragma mark - 设置infoView
- (void)setUpInfoView
{
    //设置代理
    _infoView.dataSource = self;
    _infoView.delegate = self;

    //设置分布
    _infoView.pagingEnabled = YES;
    _infoView.showsHorizontalScrollIndicator = NO;
    _infoView.backgroundColor = [UIColor clearColor];

}

#pragma mark - collevtionCellDataSource代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _exitCity_futureWeather.allKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.row >= _cityKeys.count) {
        return nil;
    }
    CurrentWeather *weather = [[CurrentWeather alloc]initWithDictionary:_exitCity_currentWeather[_cityKeys[indexPath.row]][@"weatherinfo"]];
    weather.city = _cityKeys[indexPath.row];
    InfoCell *cell = [InfoCell cellWithCollectionView:collectionView indexPath:indexPath withData:weather];
    cell.btnDelegate = self;
    [self setUpFutureWeatherView];
    [self playVideo];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(DeviceWidth, _infoView.bounds.size.height);
}
#pragma mark - 定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        currentPlace = [placemark.addressDictionary[@"City"]substringToIndex:2];
        _exitCity_futureWeather = [NetWorkTool getWeatherByCityName:currentPlace];
        _exitCity_currentWeather = [NetWorkTool getCurrentByCityName:currentPlace];
        _cityKeys = [_exitCity_currentWeather.allKeys sortedArrayUsingSelector:@selector(compare:)];
        _pageControl.numberOfPages = _cityKeys.count;
        [self.infoView reloadData];
    }];
    [_locationManager stopUpdatingLocation];
}
#pragma mark - 按钮代理事件
- (void)deleteWeatherByCityName:(NSString *)name
{
    if (_cityKeys.count == 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tips" message:@"No more weather ot show" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    _exitCity_currentWeather = [_tool deleteDataByCityName:name];
    _exitCity_futureWeather = [_tool deleteFutureDataByCityName:name];
    _cityKeys = [_exitCity_currentWeather.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (int i = 0; i < _cityKeys.count; i++) {
        if ([_cityKeys[i] isEqualToString:name]) {
            
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
            _indexPath = index;
        }
    }
    /*
     ui删除
     */
    [self.infoView deleteItemsAtIndexPaths:@[_indexPath]];
    _pageControl.numberOfPages = _cityKeys.count;
    [self setUpFutureWeatherView];
}
- (void)refreshWeatherByCityName:(NSString *)name
{

    _exitCity_currentWeather = [NetWorkTool getCurrentByCityName:name];
    _exitCity_futureWeather = [NetWorkTool getWeatherByCityName:name];
    [self.infoView reloadData];
    [self setUpFutureWeatherView];
}
#pragma mark - 按钮事件
//跳转到搜索页面进行添加
- (IBAction)addCity:(id)sender {
    SearchViewController *search = [[SearchViewController alloc]init];
    search.cellDelegate = self;
    [self presentViewController:search animated:YES completion:nil];
}
//进行定位且回到第一页
- (IBAction)locatedPressed:(id)sender {
    [_locationManager startUpdatingLocation];
    [self changeUIWithName:currentPlace];
}

#pragma mark - 获取数据
- (void)getDataFromDelegate
{
    _tool = [DataSpreadTool new];
    self.dataDelegate = _tool;
    _exitCity_currentWeather = [_tool dataforCurrentWeather];
    _exitCity_futureWeather = [_tool dataForFutureWeather];
    _cityKeys = [[_exitCity_currentWeather allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _pageControl.numberOfPages = _exitCity_currentWeather.count;
}
#pragma mark - 把所有子视图回前面
- (void)bringAllSubViewTofront
{
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[_player.view class]]) {
            [self.view bringSubviewToFront:view];
        }
    }
}
#pragma mark -设置偏移位置
- (void)changeUIWithName:(NSString *)name
{
    [self getDataFromDelegate];
    for (int i = 0; i < _cityKeys.count; i++) {
        if ([_cityKeys[i] isEqualToString:name]) {
            [self.infoView setContentOffset:CGPointMake(375*i, 0) animated:YES];
        }
    }
}

@end
