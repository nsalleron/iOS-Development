//
//  ViewController.m
//  NuancierRVBprog
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "ViewController.h"
#import "mainView.h"

@interface ViewController ()

@end

@implementation ViewController
mainView* v;
UIColor* defaultColor;
UIColor* currentColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     v= [[mainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [v setBackgroundColor:[UIColor whiteColor]];
    [self setView:v];
    [v release];
    
    defaultColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
    [defaultColor retain];
    
    [[(mainView*) self.view prec0] setBackgroundColor:defaultColor];
    [[v prec1] setBackgroundColor:defaultColor];
    [[v prec2] setBackgroundColor:defaultColor];
    [[v prec3] setBackgroundColor:defaultColor];
}

- (void)fctRetrieveColor:(UIButton *)sender {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    [[sender backgroundColor] getRed:&red green:&green blue:&blue alpha:nil];
    
    [[v sldrR] setValue:(int)(red*255)];
    [[v sldrV] setValue:(int)(green*255)];
    [[v sldrB] setValue:(int)(blue*255)];
    
    NSLog(@"RED : %lf, GREEN : %lf, BLUE : %lf",red,green,blue);
    currentColor = [UIColor colorWithRed:red
                                   green:green
                                    blue:blue alpha:1];
    [currentColor retain];
    [[v prec0] setBackgroundColor:currentColor];
    
    [self fctAffichage];
    
}

- (void)fctRGB:(UISlider *)sender {
    
    [currentColor release];
    currentColor = [UIColor colorWithRed:[[v sldrR] value]/255
                                   green:[[v sldrV]  value]/255
                                    blue:[[v sldrB]  value]/255 alpha:1];
    [currentColor retain];
    NSLog(@"Passage fctRGB");
    
    [self fctAffichage];
    
}

- (void) fctAffichage{
    NSLog(@"Passage fctAffichage");
    [[v prec0] setBackgroundColor:currentColor];
    
    if([[v swtchWeb]  isOn]){
        //Calcul du pourcentage du RVB
        [[v labelR]  setText:[NSString stringWithFormat:@"R: %d%%",(int)
                          (((int)([[v sldrR] value]*100)/255)/10)*10]];
        [[v labelV]  setText:[NSString stringWithFormat:@"V: %d%%",(int)
                          (((int)([[v sldrV] value]*100)/255)/10)*10]];
        [[v labelB] setText:[NSString stringWithFormat:@"B: %d%%",(int)
                          (((int)([[v sldrB] value]*100)/255)/10)*10]];
        
    }else{
        //Calcul du pourcentage du RVB
        [[v labelR] setText:[NSString stringWithFormat:@"R: %d%%",(int)([[v sldrR] value]*100)/255]];
        [[v labelV] setText:[NSString stringWithFormat:@"V: %d%%",(int)([[v sldrV] value]*100)/255]];
        [[v labelB] setText:[NSString stringWithFormat:@"B: %d%%",(int)([[v sldrB] value]*100)/255]];
        
    }
    
    
}

- (void)fctMem:(id)sender {
    
    [ v setNbMemoriser:[v nbMemoriser]+1];
    
    
    [[v prec3] setBackgroundColor:[[v prec2] backgroundColor]];
    [[v prec2] setBackgroundColor:[[v prec1] backgroundColor]];
    [[v prec1] setBackgroundColor:[[v prec0] backgroundColor]];
    [[v prec0] setBackgroundColor:currentColor];
    
    [self fctAffichage];
    [v dessineDansFormat:[v bounds].size];
}

- (void)fctRAZ:(id)sender {
    [[v prec0] setBackgroundColor:defaultColor];
    [[v sldrR] setValue:0];
    [[v sldrV] setValue:0];
    [[v sldrB] setValue:0];
    [self fctAffichage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [v dessineDansFormat:size];
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (void)switchWeb:(id)sender {
    [self fctAffichage];
    if([(UISwitch*)sender isOn]){
        [[v sldrR] setValue:(int)((((int)([[v sldrR] value]*100)/255)/10)*10*255)/100];
        [[v sldrV] setValue:(int)((((int)([[v sldrV] value]*100)/255)/10)*10*255)/100];
        [[v sldrB] setValue:(int)((((int)([[v sldrB] value]*100)/255)/10)*10*255)/100];
    }
}


@end
