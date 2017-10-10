//
//  ViewController.h
//  NuancierRVBprog
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (void)fctRetrieveColor:(UIButton *)sender;
- (void)fctRGB:(UISlider *)sender;
- (void) fctAffichage;
- (void)fctMem:(id)sender;
- (void)fctRAZ:(id)sender;
- (void)switchWeb:(id)sender;
@end

