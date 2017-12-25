//
//  SEFileSave.h
//  SEFileSave
//
//  Created by Sean on 2017/9/28.
//  Copyright © 2017年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEFileSave : NSObject

//存


+ (void)saveFileWithData:(NSData *)data
                fileName:(NSString *)fileName
                 success:(void (^)())success
                 failure:(void (^)())failure;


//取

+ (NSData *)getFileWithFileName:(NSString *)fileName
                        success:(void (^)())success
                        failure:(void (^)())failure;

//删
+ (void)deleteFileWithFileName:(NSString *)fileName
                       success:(void (^)())success
                       failure:(void (^)())failure;


//下载(小文件)
+ (void)downLoadFileWithFileName:(NSString *)fileName
                         withUrl:(NSString *)url
                         success:(void (^)(NSString *path))success
                         failure:(void (^)())failure;

@end

