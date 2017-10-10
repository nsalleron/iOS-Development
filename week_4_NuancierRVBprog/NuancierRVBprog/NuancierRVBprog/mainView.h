//
//  mainView.h
//  NuancierRVBprog
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainView : UIView

@property (readwrite,nonatomic, assign) UIButton* prec0;
@property (readwrite,nonatomic, assign) UIButton* prec1;
@property (readwrite,nonatomic, assign) UIButton* prec2;
@property (readwrite,nonatomic, assign) UIButton* prec3;

@property (readwrite, nonatomic, assign) UILabel* label0;
@property (readwrite, nonatomic, assign) UILabel* label1;
@property (readwrite, nonatomic, assign) UILabel* label2;
@property (readwrite, nonatomic, assign) UILabel* label3;

@property (readwrite, nonatomic, assign) UILabel* labelR;
@property (readwrite, nonatomic, assign) UILabel* labelV;
@property (readwrite, nonatomic, assign) UILabel* labelB;

@property (readwrite, nonatomic, assign) UISlider* sldrR;
@property (readwrite, nonatomic, assign) UISlider* sldrV;
@property (readwrite, nonatomic, assign) UISlider* sldrB;

@property (readwrite,nonatomic, assign) UIButton* btnMem;
@property (readwrite,nonatomic, assign) UIButton* btnRaz;

@property (readwrite,nonatomic, assign) UISwitch* swtchWeb;
@property (readwrite,nonatomic, assign) UILabel* labelWeb;
@property (readwrite, nonatomic, assign) int nbMemoriser;

- (void) dessineDansFormat:(CGSize) format;

@end
