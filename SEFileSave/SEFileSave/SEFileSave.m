//
//  SEFileSave.m
//  SEFileSave
//
//  Created by Sean on 2017/9/28.
//  Copyright © 2017年 Sean. All rights reserved.
//

#import "SEFileSave.h"

@implementation SEFileSave

+ (void)saveFileWithData:(NSData *)data
                fileName:(NSString *)fileName
                 success:(void (^)())success
                 failure:(void (^)())failure
{
    
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Music/",NSHomeDirectory()];//沙盒路径
    //    NSString *path = [paths objectAtIndex:0];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isSuc = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    if(!isSuc)
    {
        NSLog(@"创建失败");
        
    }
    NSString *allPath = [NSString stringWithFormat:@"%@%@",path,fileName];
    BOOL isWriteSuc = [data writeToFile:allPath atomically:YES];
    if(isWriteSuc)
    {
        NSLog(@"%@",allPath);
        if(success)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                success();
            });
        }
        
        
    }
    else
    {
        if(failure)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                failure();
            });
        }
    }
    
}



+ (NSData *)getFileWithFileName:(NSString *)fileName
                        success:(void (^)())success
                        failure:(void (^)())failure
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Music/%@",NSHomeDirectory(),fileName];
    NSFileManager *manage  = [NSFileManager defaultManager];
    if (![manage fileExistsAtPath:path])
    {
        
        if(failure)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                failure();
            });
        }
        return nil;
        
    }else
    {
        if(success)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                success();
            });
        }
        NSLog(@"%@",path);
        
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
    
    
}


+ (void)deleteFileWithFileName:(NSString *)fileName
                       success:(void (^)())success
                       failure:(void (^)())failure;
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Music/%@",NSHomeDirectory(),fileName];
    NSFileManager *manage  = [NSFileManager defaultManager];
    if (![manage fileExistsAtPath:path])
    {
        if(failure)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                failure();
            });
        }
        
    }
    if([manage fileExistsAtPath:path])
    {
        if ([manage removeItemAtPath:path error:nil])
        {
            if(success)
            {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    success();
                });
                
            }
            
        }
    }
    
}

+ (void)downLoadFileWithFileName:(NSString *)fileName
                         withUrl:(NSString *)url
                         success:(void (^)(NSString *path))success
                         failure:(void (^)())failure;
{
    
    NSString *format = [url substringWithRange:NSMakeRange(url.length - 5, 5)];
    NSRange range = [format rangeOfString:@"."];
    format = [format substringWithRange:NSMakeRange(range.location ,format.length - range.location)];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Music/",NSHomeDirectory()];//沙盒路径
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isSuc = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    if(!isSuc)
    {
        
        NSLog(@"创建失败");
        
    }
    NSString *allPath = [NSString stringWithFormat:@"%@%@%@",path,fileName,format];
    if([manager fileExistsAtPath:allPath])
    {
        NSLog(@"文件已存在");

        if(success)
        {
            success(allPath);
 
        }
        return;
    }
    
    
    NSURL* urlFile = [NSURL URLWithString:url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlFile];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        if (connectionError) {
            NSLog(@"error");
            if(failure)
            {
                failure();
            }
            return ;
        }
        else if (((NSHTTPURLResponse *)response).statusCode == 200)
        {
            [data writeToFile:allPath atomically:YES];
            NSLog(@"下载完成");
            if(success)
            {
                success(allPath);
                
            }
        }
    }];

}


@end

