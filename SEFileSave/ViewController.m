//
//  ViewController.m
//  SEFileSave
//
//  Created by Sean on 2017/9/28.
//  Copyright © 2017年 Sean. All rights reserved.
//

#import "ViewController.h"
#import "SEFileSave.h"
 #import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic,strong)AVAudioPlayer *audioPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Maps" ofType:@"mp3"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    [SEFileSave saveFileWithData:data fileName:@"Madilyn" success:^(){
//        
//        
//
//    }failure:nil];
    [SEFileSave deleteFileWithFileName:@"Madilyn" success:Nil failure:Nil];
    NSData *dota = [SEFileSave getFileWithFileName:@"Madilyn" success:^(){

        
    } failure:nil];
    self.audioPlayer= [[AVAudioPlayer alloc] initWithData:dota error:Nil];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


@end
