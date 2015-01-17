//
//  SlideViewCell.m
//  ESPMobile
//
//  Created by Skye on 15/1/14.
//  Copyright (c) 2015年 Javor. All rights reserved.
//

#import "SlideViewCell.h"
#import "SlideViewModel.h"

@implementation SlideViewCell


-(void)setModel:(SlideViewModel *)model
{
    UIImageView *imageView = self.contentView.subviews.firstObject;
    if(imageView == nil)
    {
        imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        imageView.frame =self.contentView.bounds;
    
        
    }
    imageView.image = [UIImage imageNamed:model.picName];
    
    UILabel *label = imageView.subviews.firstObject;
    if(label==nil)
    {
        label = [[UILabel alloc] init];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        [imageView addSubview:label];
        
        [imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        
    }
    label.text = model.title;
    
}
@end
