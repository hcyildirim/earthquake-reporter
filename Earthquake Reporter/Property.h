//
//  Property.h
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 30/04/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "Earthquake.h"

@interface Property : Earthquake

    @property (nonatomic, strong) NSNumber *mag;
    @property (nonatomic, strong) NSString *place;
    @property (nonatomic, strong) NSNumber *time;
    @property (nonatomic, strong) NSString *url;
    
@end
