//
//  ParkModel.m
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import "ParkModel.h"

@implementation ParkModel
- (instancetype)initWithDic:(NSDictionary *)dict
{
  ParkModel *park = [ParkModel alloc];
  
  park.placeId = dict[@"_id"];
  park.parkName = dict[@"ParkName"];
  park.variety = dict[@"Name"];
  park.note = dict[@"Introduction"];
  park.image = dict[@"Image"];
  return park;
}
@end
