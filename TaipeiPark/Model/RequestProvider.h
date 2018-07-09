//
//  RequestProvider.h
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  GET = 0,
  POST = 1,
  UPDATE = 2,
  PUT = 3
} HTTPMethod;

@interface RequestProvider : NSObject
@property int offset;
@property int limit;
-(id) init;
-(NSURLRequest*) getRequest: (NSString*)urlString withMethod:(HTTPMethod) method;
-(NSString*) getHTTPString: (HTTPMethod) method;
-(NSMutableString*) getParkURLString;
@end
