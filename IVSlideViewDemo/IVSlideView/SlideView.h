//
//  SlideView.h
//  ESPMobile
//
//  Created by Skye on 15/1/14.
//  Copyright (c) 2015年 Javor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlideViewModel;

@interface SlideView : UIView

-(instancetype)initWithFrame:(CGRect)frame andSlideModels:(NSArray *)slideModels;

@property (nonatomic,weak,readonly) UICollectionView *collectionView;

@property (nonatomic,weak,readonly) UIPageControl *pageControl;

@end
