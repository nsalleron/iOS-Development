//
//  ViewController.m
//  NuancierRVB
//
//  Created by Nicolas Salleron on 25/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

UIColor* defaultColor;
UIColor* currentColor;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    defaultColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
    [defaultColor retain];
    
    [_btnActuel setBackgroundColor:defaultColor];
    [_btnPrecedent setBackgroundColor:defaultColor];
    [_btnPenultieme setBackgroundColor:defaultColor];
    [_btnAntepultieme setBackgroundColor:defaultColor];
    
}

- (IBAction)fctRetrieveColor:(UIButton *)sender {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    [[sender backgroundColor] getRed:&red green:&green blue:&blue alpha:nil];
    
    [_sliderR setValue:(int)(red*255)];
    [_sliderV setValue:(int)(green*255)];
    [_sliderB setValue:(int)(blue*255)];
    
    NSLog(@"RED : %lf, GREEN : %lf, BLUE : %lf",red,green,blue);
    currentColor = [UIColor colorWithRed:red
                                green:green
                                 blue:blue alpha:1];
    [currentColor retain];
    [_btnActuel setBackgroundColor:currentColor];
    
}

- (IBAction)fctRGB:(UISlider *)sender {
    
    [currentColor release];
    currentColor = [UIColor colorWithRed:[_sliderR value]/255
                                   green:[_sliderV value]/255
                                    blue:[_sliderB value]/255 alpha:1];
    [currentColor retain];
    
    [self fctAffichage];
    
}

- (void) fctAffichage{
    
    [_btnActuel setBackgroundColor:currentColor];
    
    if([_switchWeb isOn]){
        //Calcul du pourcentage du RVB
        [_labelR setText:[NSString stringWithFormat:@"R: %d%%",(int)
                          (((int)([_sliderR value]*100)/255)/10)*10]];
        [_labelV setText:[NSString stringWithFormat:@"V: %d%%",(int)
                          (((int)([_sliderV value]*100)/255)/10)*10]];
        [_labelB setText:[NSString stringWithFormat:@"B: %d%%",(int)
                          (((int)([_sliderB value]*100)/255)/10)*10]];

    }else{
        //Calcul du pourcentage du RVB
        [_labelR setText:[NSString stringWithFormat:@"R: %d%%",(int)([_sliderR value]*100)/255]];
        [_labelV setText:[NSString stringWithFormat:@"V: %d%%",(int)([_sliderV value]*100)/255]];
        [_labelB setText:[NSString stringWithFormat:@"B: %d%%",(int)([_sliderB value]*100)/255]];

    }
    
    //NSLog(@"R : %@%%",[NSString stringWithFormat:@"%d",(int)([_sliderR value]*100)/255]);
    
    
}

- (IBAction)fctMemoriser:(id)sender {
    
    
    [_btnAntepultieme setBackgroundColor:[_btnPenultieme backgroundColor]];
    [_btnPenultieme setBackgroundColor:[_btnPrecedent backgroundColor]];
    [_btnPrecedent setBackgroundColor:[_btnActuel backgroundColor]];
    [_btnActuel setBackgroundColor:currentColor];
    
}

- (IBAction)fctRAZ:(id)sender {
    [_btnActuel setBackgroundColor:defaultColor];
    [_sliderR setValue:0];
    [_sliderV setValue:0];
    [_sliderB setValue:0];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_btnAntepultieme release];
    [_btnPenultieme release];
    [_btnPrecedent release];
    [_btnActuel release];
    [_sliderV release];
    [_sliderV release];
    [_sliderR release];
    [_sliderV release];
    [_sliderB release];
    [_sliderB release];
    [_labelR release];
    [_labelV release];
    [_labelB release];
    [_switchWeb release];
    [super dealloc];
}

- (IBAction)switchWeb:(id)sender {
    [self fctAffichage];
    if([(UISwitch*)sender isOn]){
        [_sliderR setValue:(int)((((int)([_sliderR value]*100)/255)/10)*10*255)/100];
        [_sliderV setValue:(int)((((int)([_sliderV value]*100)/255)/10)*10*255)/100];
        [_sliderB setValue:(int)((((int)([_sliderB value]*100)/255)/10)*10*255)/100];
    }
}
@end
