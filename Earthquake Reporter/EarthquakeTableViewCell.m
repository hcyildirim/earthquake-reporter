//
//  EarthquakeTableViewCell.m
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 30/04/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "EarthquakeTableViewCell.h"

@implementation EarthquakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    // label with circle
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _labelMagnitude.bounds;
    circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)].CGPath;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.lineWidth = 2;
    
    // add layer to label
    
    [_labelMagnitude.layer addSublayer:circleLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
