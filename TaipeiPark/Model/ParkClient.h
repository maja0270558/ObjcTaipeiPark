//
//  ParkClient.h
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkClient : NSObject
+(void) requestWith:(NSURLRequest*)request completion:(void(^)(NSData*))callback;
@end
