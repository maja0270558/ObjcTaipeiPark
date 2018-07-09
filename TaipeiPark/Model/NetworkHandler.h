//
//  NetworkHandler.h
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/7.
//  Copyright © 2018年 Django. All rights reserved.
//

#ifndef NetworkHandler_h
#define NetworkHandler_h
@interface NetworkHandler: NSObject
+(void) requestWith:(NSURLRequest*)request completion:(void(^)(NSData*))callback;
@end

#endif /* NetworkHandler_h */
