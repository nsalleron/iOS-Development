//
//  ViewController.h
//  NuancierRVB
//
//  Created by Nicolas Salleron on 25/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *btnAntepultieme;
@property (retain, nonatomic) IBOutlet UIButton *btnPenultieme;
@property (retain, nonatomic) IBOutlet UIButton *btnPrecedent;
@property (retain, nonatomic) IBOutlet UIButton *btnActuel;

@property (retain, nonatomic) IBOutlet UISlider *sliderR;
@property (retain, nonatomic) IBOutlet UISlider *sliderV;
@property (retain, nonatomic) IBOutlet UISlider *sliderB;
@property (retain, nonatomic) IBOutlet UILabel *labelR;
@property (retain, nonatomic) IBOutlet UILabel *labelV;
@property (retain, nonatomic) IBOutlet UILabel *labelB;
@property (retain, nonatomic) IBOutlet UISwitch *switchWeb;

- (IBAction)switchWeb:(id)sender;

@end

