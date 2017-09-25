//
//  ViewController.m
//  Bonrevoir
//
//  Created by Nicolas Salleron on 18/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelText;


@end

@implementation ViewController

bool change = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)labelChange:(id)sender {
   
    if(!change){
        [_labelText setText:@"Bonjour !!!"];
        [(UIButton*) sender setTitle:@"Dis au revoir !" forState:UIControlStateNormal];
        change = true;
    }else{
        [_labelText setText:@"Au revoir !!!"];
        [(UIButton*) sender setTitle:@"Dis bonjour !" forState:UIControlStateNormal];
        change = false;
    }
   
}


@end
