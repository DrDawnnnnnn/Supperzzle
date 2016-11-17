//
//  ViewController.m
//  对对碰
//
//  Created by 杨晓鸣 on 16/9/19.
//  Copyright © 2016年 杨晓鸣. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray* arrStr = [[NSMutableArray alloc]init];
    
    for (int k = 0; k<18; k++) {
        int random = arc4random()%7+1;
        NSString* strName = [NSString stringWithFormat:@"%d",random];
        
        [arrStr addObject:strName];
        [arrStr addObject:strName];
        
    }
    
    //循环创建36个按钮
    for (int i = 0; i<6; i++) {
        for (int j = 0; j<6; j++)
        {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [UIView beginAnimations:nil context:nil];
            btn.frame = CGRectMake(160, 160, 50, 50);
            [UIView setAnimationDuration:2];
            btn.frame = CGRectMake(10+50*j, 40+50*i, 50, 50);
            [UIView commitAnimations];
            
            //产生随机图片
            int indexramdom = arc4random() % arrStr.count;
            //从图像数组中取出文件名
            NSString* strImage = arrStr[indexramdom];
            
            NSInteger tag = [strImage integerValue];
            
            [arrStr removeObjectAtIndex:indexramdom];
            
            UIImage* image = [UIImage imageNamed:strImage];
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            
            //将按钮的标志位赋值
            btn.tag = tag;
        }
    }

}

-(void) pressBtn:(UIButton*) btn
{
    //创建一个静态变量 保存第一次按下的按钮
    static UIButton* btnFirst = nil;
    if (btnFirst == nil) {
        btnFirst = btn;
        //锁定第一个按钮
        btnFirst.enabled = NO;
    }
    else{
        //两个图片相同
        if (btnFirst.tag == btn.tag) {
            btnFirst.hidden = YES;
            btn.hidden = YES;
            btnFirst = nil;
        }
        //按钮图片不相同
        else{
            btnFirst.enabled = YES;
            btnFirst = nil;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
