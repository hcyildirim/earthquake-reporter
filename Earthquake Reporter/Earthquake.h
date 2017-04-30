//
//  Earthquake.h
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 30/04/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Property;

@interface Earthquake : NSObject

    @property (nonatomic, strong) NSString *id;
    @property (nonatomic, strong) NSString *type;
    @property (nonatomic, strong) Property *property;
    
@end
