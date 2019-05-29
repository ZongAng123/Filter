//
//  FilterView.h
//  FilterDemo
//
//  Created by 纵昂 on 2019/5/28.
//  Copyright © 2019 GitHub:https://github.com/ZongAng123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FilterView;

@protocol FilterViewDelegate <NSObject>

@optional

- (void)filterView:(FilterView *)filterView chooseFilterName:(NSString *)filterName;

- (void)filterView:(FilterView *)filterView cancelBtnClick:(UIButton *)cancelBtn;

@end

@interface FilterView : UIView

@property (nonatomic, weak) id<FilterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
