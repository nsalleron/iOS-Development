//
//  ViewController.m
//  Dizainier
//
//  Created by Nicolas Salleron on 25/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_stepper setValue:0];
    [_Dizaines setSelectedSegmentIndex:([_stepper value]/10)];
    [_Unites setSelectedSegmentIndex:fmod([_stepper value], 10)];
    
    NSLog(@"Dizaine : %ld et Unités : %ld",(long)[_Dizaines selectedSegmentIndex],(long)[_Unites selectedSegmentIndex]);
    
    NSLog(@"Description Dizaine : %@",[_Dizaines description]);
    NSLog(@"Description Unites : %@",[_Unites description]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeMode:(id)sender {
    [self affichageResult];
}
- (IBAction)fctCalc:(UISegmentedControl *)sender {
    //NSLog(@"=> Description %@",[sender description]);
    
    
    if([sender isEqual:_Dizaines]){
        
        
        NSLog(@"Dizaines %ld", (int)fmod([_stepper value], 10) +(int)10*[sender selectedSegmentIndex]);
        [_stepper setValue:(int)fmod([_stepper value], 10)
         +(int)10*[sender selectedSegmentIndex]];
        
        
    }else if([sender isEqual:_Unites]){
        NSLog(@"Stepper value : %d Unites %ld", (int) [_stepper value], [sender selectedSegmentIndex]);
        [_stepper setValue:(int)(((int)[_stepper value])/10)*10
                            +[sender selectedSegmentIndex]];
        
        NSLog(@"Result : %f",[_stepper value]);
        
    }else{  //Demande d'actualisation d'affichage;
        [_Dizaines setSelectedSegmentIndex:[_stepper value]/10];
        [_Unites setSelectedSegmentIndex:fmod([_stepper value], 10)];
        [_Slider setValue:[_stepper value]];
    }
   
    
    [self affichageResult];
    
    
}
- (IBAction)changeStepper:(id)sender {
    [self fctCalc:nil];
    NSLog(@"Valeur Stepper : %d",(int)[_stepper value]);
}

- (IBAction)changeSlider:(UISlider*)sender {
  
}
- (IBAction)btnRAZ:(UIButton *)sender {
    [_stepper setValue:0];
    [self fctCalc:nil];
}

-(void) affichageResult{
    int result = [_stepper value];
    
    //Affichage du resultat
    if([_modeGeek isOn]){
        [_result setText:[NSString stringWithFormat:@"%x",result]];
    }else{
        [_result setText:[NSString stringWithFormat:@"%d",result]];
    }
    
    //Affichage de la couleur
    if( result == 42)
        [_result setTextColor:[UIColor redColor]];
    else
        [_result setTextColor:[UIColor blackColor]];
    
    [_Slider setValue:result];
    
}

- (void)dealloc {
    [_Dizaines release];
    [_Unites release];
    [_stepper release];
    [_modeGeek release];
    [_Slider release];
    [_btnRAZ release];
    [_result release];
    [_Unites release];
    [super dealloc];
}
@end
