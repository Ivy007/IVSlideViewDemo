//
//  SlideView.m
//  ESPMobile
//
//  Created by Skye on 15/1/14.
//  Copyright (c) 2015年 Javor. All rights reserved.
//
#define TIMER 3
#import "SlideView.h"
#import "SlideViewCell.h"

static NSString * ID = @"cellID";

@interface SlideView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong) NSArray *slideModels;

@property (nonatomic,strong) NSIndexPath *nowIndex;

@property (nonatomic,strong) NSIndexPath *showedIndex;
@property(nonatomic,weak) NSTimer *timer;
@end

@implementation SlideView

-(instancetype)initWithFrame:(CGRect)frame andSlideModels:(NSArray *)slideModels
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.slideModels = slideModels;
        [self setupCollectionView];
        
        [self.collectionView registerClass:[SlideViewCell class] forCellWithReuseIdentifier:ID];
        [self setupPageControl];
        
        [self createTimerWithSecond:TIMER];
        
        
    }
    return self;
}
-(void)createTimerWithSecond:(float) sec
{
     self.timer =  [NSTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(nextSlide) userInfo:nil repeats:YES];
}

-(void)distroyTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)nextSlide
{
    long item = self.nowIndex.item +1;
    long section = self.nowIndex.section;
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    self.nowIndex = nextIndexPath;
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
/**
 *  创建collectionView
 */
-(void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置layout
    layout.itemSize = self.frame.size;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    NSLog(@"%f",self.frame.size.width);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    _collectionView =collectionView;
    self.collectionView.pagingEnabled = YES;
    [self addSubview:self.collectionView];
}
/**
 *  创建pageControl
 */
-(void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.numberOfPages = self.slideModels.count;
    pageControl.currentPage = 0;
    pageControl.tintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor= [UIColor orangeColor];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    _pageControl = pageControl;
    [self addSubview:pageControl];
    
    //添加autolayout约束
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageControl)]];
    
    
}
#pragma mark collectionview DateSource;

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.slideModels.count * 1000;
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SlideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
   if(!self.nowIndex) self.nowIndex = indexPath;
    cell.model = self.slideModels[indexPath.item % self.slideModels.count];
    
    return cell;
}

#pragma  collectionView 的代理方法
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.showedIndex = indexPath;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.showedIndex = indexPath;
}
#pragma scollview Delegate
/**
 *  开始拖动时移除控制器
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self distroyTimer];
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.nowIndex = self.showedIndex;

    [self createTimerWithSecond:TIMER];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   self.pageControl.currentPage = (int)(scrollView.contentOffset.x /self.frame.size.width) % self.slideModels.count;
}
@end
