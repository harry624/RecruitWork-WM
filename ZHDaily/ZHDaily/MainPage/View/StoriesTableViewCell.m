//
//  StoriesTableViewCell.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/21.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "StoriesTableViewCell.h"
#import "StoriesModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface StoriesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *mutiImgView;

@end
@implementation StoriesTableViewCell

- (void)setStoryModel:(StoriesModel *)model{
    NSString *title = model.title;
    self.titleLabel.text = title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.images.firstObject]];
    if (model.isMultipic) {
        self.mutiImgView.hidden = NO;
        self.mutiImgView.image = [UIImage imageNamed:@"Home_Morepic"];
    }else{
        self.mutiImgView.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
