//
//  ViewController.h
//  Dizainier
//
//  Created by Nicolas Salleron on 25/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UISegmentedControl *Dizaines;
@property (retain, nonatomic) IBOutlet UISegmentedControl *Unites;
@property (retain, nonatomic) IBOutlet UIStepper *stepper;
@property (retain, nonatomic) IBOutlet UISwitch *modeGeek;
@property (retain, nonatomic) IBOutlet UISlider *Slider;
@property (retain, nonatomic) IBOutlet UIButton *btnRAZ;
@property (retain, nonatomic) IBOutlet UILabel *result;

- (void) affichageResult;

@end

