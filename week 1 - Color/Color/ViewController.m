//
//  ViewController.m
//  Color
//
//  Created by Nicolas Salleron on 18/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundColor;
@property (nonatomic) int nb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(id)sender {
    UIStepper* step = sender;
    [step setValue:((int)[step value]%8)];
    switch ((int)[step value]) {
        case 0:
            [_backgroundColor setBackgroundColor:[UIColor whiteColor]];
            break;
        case 1:
            [_backgroundColor setBackgroundColor:[UIColor greenColor]];
            break;
        case 2:
            [_backgroundColor setBackgroundColor:[UIColor redColor]];
            break;
        case 3:
            [_backgroundColor setBackgroundColor:[UIColor blueColor]];
            break;
        case 4:
            [_backgroundColor setBackgroundColor:[UIColor yellowColor]];
            break;
        case 5:
            [_backgroundColor setBackgroundColor:[UIColor orangeColor]];
            break;
        case 6:
            [_backgroundColor setBackgroundColor:[UIColor purpleColor]];
            break;
        case 7:
            [_backgroundColor setBackgroundColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
    
    
}

@end
