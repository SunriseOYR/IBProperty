//
//  ViewController.m
//  IBPropertyDemo
//
//  Created by OrangesAL on 2018/1/23.
//  Copyright © 2018年 OrangesAL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)action_reClickTest:(id)sender {
    
    [self.view endEditing:YES];
    static int i = 0;
    self.textView.text = [NSString stringWithFormat:@"点击效果 %d", ++i];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
