//
//  ViewController.m
//  Imagier
//
//  Created by Nicolas Salleron on 16/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "ViewController.h"
#import "MaVue.h"

@interface ViewController ()

@end

@implementation ViewController

MaVue *v;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    v =[[MaVue alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:v];
    [v release];
    
}


- (BOOL) prefersStatusBarHidden{
    return TRUE;
}

- (void) changeImage: (UIBarButtonItem*) _sender{
    if(_sender == [v back]){
        v.indexTableau = ([v indexTableau] -1 ) % 19;
        if(v.indexTableau == -1){
            v.indexTableau = 19;
        }
    }else{
        v.indexTableau = ([v indexTableau] +1 ) % 19;
    }
    [v changeImage];
    //[v scrollViewDidEndZooming:v.scrollV withView:v atScale:0.05];
    
}

- (void) changeZoom{
    [v scrollViewDidEndZooming:v.scrollV withView:v atScale:v.sldrImage.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [v DessineDansFormat:size];
}

- (BOOL)shouldAutorotate{
    return YES;
}


@end
