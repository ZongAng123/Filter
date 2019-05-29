//
//  FilterNameCell.m
//  FilterDemo
//
//  Created by 纵昂 on 2019/5/28.
//  Copyright © 2019 GitHub:https://github.com/ZongAng123. All rights reserved.
//

#import "FilterNameCell.h"

@interface FilterNameCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation FilterNameCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setFilterName:(NSString *)filterName {
    _filterName = filterName;
    
    self.nameLabel.text = filterName;
    [self.nameLabel sizeToFit];
}


@end
