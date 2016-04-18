//
//  ProgressController.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "ProgressController.h"
#import "ProgressView.h"
#import "ProgressViewSecond.h"
@interface ProgressController ()

@property (weak, nonatomic) IBOutlet ProgressViewSecond *secondView;
@property (weak, nonatomic) IBOutlet ProgressView *firstView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end
@implementation ProgressController
- (void)viewDidLoad{
    [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
}
- (void)sliderValueChange:(UISlider *)slider{
    self.firstView.progress = slider.value;
    self.secondView.progress = slider.value;
}
@end
