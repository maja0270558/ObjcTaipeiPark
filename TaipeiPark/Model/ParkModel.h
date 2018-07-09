//
//  ParkModel.h
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkModel : NSObject
@property (strong, nonatomic) NSString* placeId;
@property (strong, nonatomic) NSString* parkName;
@property (strong, nonatomic) NSString* variety;
@property (strong, nonatomic) NSString* note;
@property (strong, nonatomic) NSString* image;

-(instancetype) initWithDic:(NSDictionary*) dic;
@end
