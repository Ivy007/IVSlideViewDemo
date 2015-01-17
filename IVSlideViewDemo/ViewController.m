//
//  ViewController.m
//  IVSlideViewDemo
//
//  Created by Skye on 15/1/17.
//  Copyright (c) 2015年 fly. All rights reserved.
//

#import "ViewController.h"
#import "SlideView.h"
#import "SlideViewModel.h"


@interface ViewController ()

@property (nonatomic,strong) NSArray *slideArray;

@end

@implementation ViewController

-(NSArray *)slideArray
{
    if(!_slideArray)
    {
        SlideViewModel *model1 = [[SlideViewModel alloc] init];
        model1.title =@"1";
        model1.picName = @"1.jpg";
        
        SlideViewModel *model2 = [[SlideViewModel alloc] init];
        model2.title =@"2";
        model2.picName = @"2.jpg";
        
        SlideViewModel *model3 = [[SlideViewModel alloc] init];
        model3.title =@"3";
        model3.picName = @"3.jpg";
        
        SlideViewModel *model4 = [[SlideViewModel alloc] init];
        model4.title =@"4";
        model4.picName = @"4.jpg";
        
        SlideViewModel *model5 = [[SlideViewModel alloc] init];
        model5.title =@"5";
        model5.picName = @"5.jpg";
        _slideArray = @[model1,model2,model3,model4,model5];
    }
    return _slideArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加数据源
    
    SlideView *slideView = [[SlideView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 150) andSlideModels:self.slideArray];
    //固定写法
    [slideView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self.view addSubview:slideView];
}
@end
