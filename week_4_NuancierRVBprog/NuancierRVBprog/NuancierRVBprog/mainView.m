//
//  mainView.m
//  NuancierRVBprog
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "mainView.h"
#import "ViewController.h"

@implementation mainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

float tailleIcones = 0 ;


- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _nbMemoriser = 0;
        
        _label0 = [[UILabel alloc] init];
        [_label0 setText:@"Actuel"];
        _label1 = [[UILabel alloc] init];
        [_label1 setText:@"Précédent"];
        _label2 = [[UILabel alloc] init];
        [_label2 setText:@"Prénultième"];
        _label3 = [[UILabel alloc] init];
        [_label3 setText:@"Anté-pénultième"];
        
        _prec0 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_prec0 setBackgroundColor:[UIColor yellowColor]];
        [_prec0 addTarget:self.superview action:@selector(fctRetrieveColor:) forControlEvents:UIControlEventTouchUpInside];
        _prec1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_prec1 setBackgroundColor:[UIColor orangeColor]];
        [_prec1 addTarget:self.superview action:@selector(fctRetrieveColor:) forControlEvents:UIControlEventTouchUpInside];
        _prec2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_prec2 setBackgroundColor:[UIColor purpleColor]];
        [_prec2 addTarget:self.superview action:@selector(fctRetrieveColor:) forControlEvents:UIControlEventTouchUpInside];
        _prec3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_prec3 setBackgroundColor:[UIColor greenColor]];
        [_prec3 addTarget:self.superview action:@selector(fctRetrieveColor:) forControlEvents:UIControlEventTouchUpInside];
        
        _labelR = [[UILabel alloc] init];
        [_labelR setText:@"R : 0%"];
        _labelV = [[UILabel alloc] init];
        [_labelV setText:@"V : 0%"];
        _labelB = [[UILabel alloc] init];
        [_labelB setText:@"B : 0%"];
        
        _sldrR = [[UISlider alloc] init];
        [_sldrR setMinimumValue:0];
        [_sldrR setMaximumValue:255];
        [_sldrR setValue:1 animated:true];
        [_sldrR setThumbTintColor:[UIColor redColor]];
        [_sldrR setTintColor:[UIColor redColor]];
        _sldrV = [[UISlider alloc] init];
        [_sldrV setMinimumValue:0];
        [_sldrV setMaximumValue:255];
        [_sldrV setThumbTintColor:[UIColor greenColor]];
        [_sldrV setValue:1 animated:true];
        [_sldrV setTintColor:[UIColor greenColor]];
        _sldrB = [[UISlider alloc] init];
        [_sldrB setMinimumValue:0];
        [_sldrB setMaximumValue:255];
        [_sldrB setValue:1 animated:true];
        [_sldrB setThumbTintColor:[UIColor blueColor]];
        [_sldrB setTintColor:[UIColor blueColor]];
        
        [_sldrR addTarget:self.superview action:@selector(fctRGB:) forControlEvents:UIControlEventValueChanged];
        [_sldrV addTarget:self.superview action:@selector(fctRGB:) forControlEvents:UIControlEventValueChanged];
        [_sldrB addTarget:self.superview action:@selector(fctRGB:) forControlEvents:UIControlEventValueChanged];
        
        _btnMem = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnMem setTitle:@"Mémoriser" forState:UIControlStateNormal];
        [_btnMem addTarget:self.superview action:@selector(fctMem:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnRaz = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnRaz setTitle:@"RaZ" forState:UIControlStateNormal];
        [_btnRaz addTarget:self.superview action:@selector(fctRAZ:) forControlEvents:UIControlEventTouchUpInside];
        
        _swtchWeb = [[UISwitch alloc] init];
        [_swtchWeb setOn:false];
        [_swtchWeb addTarget:self.superview action:@selector(switchWeb:) forControlEvents:UIControlEventValueChanged];
        
        _labelWeb = [[UILabel alloc] init];
        [_labelWeb setText:@"Web"];
        
        [self addSubview:_label0];
        [self addSubview:_label1];
        [self addSubview:_label2];
        [self addSubview:_label3];
        [self addSubview:_prec0];
        [self addSubview:_prec1];
        [self addSubview:_prec2];
        [self addSubview:_prec3];
        [self addSubview:_labelR];
        [self addSubview:_labelV];
        [self addSubview:_labelB];
        [self addSubview:_sldrR];
        [self addSubview:_sldrV];
        [self addSubview:_sldrB];
        [self addSubview:_btnMem];
        [self addSubview:_btnRaz];
        [self addSubview:_swtchWeb];
        [self addSubview:_labelWeb];
        
        /* Manque les sélectors */
        
        
        
        [_label0 release];
        [_label1 release];
        [_label2 release];
        [_label3 release];
        
        [_labelR release];
        [_labelV release];
        [_labelB release];
        
        [_sldrR release];
        [_sldrV release];
        [_sldrB release];
        
        [_swtchWeb release];
        [_labelWeb release];
        [self dessineDansFormat:frame.size];
    }
    return self;
}



- (void) dessineDansFormat:(CGSize) format{
    tailleIcones = format.height / 3 - 30;
    
    NSLog(@"val nb : %d format height %f",_nbMemoriser, format.height);
   
    if( format.height > 400 ){  //On est en portrait sur Iphone 5S.
        NSLog(@"PORTRAIT");
        
        switch (_nbMemoriser) {
            case 0:
                //trololo
                [_label0 setFrame:CGRectMake(20, 20, tailleIcones, tailleIcones/6)];
                [_prec0 setFrame:CGRectMake(20, 20 + tailleIcones/6, format.width - 40,format.height/2 - 80)];
                break;
                
            case 1:
                // Diviser par 2
                [_label1 setFrame:CGRectMake(20, 20, tailleIcones, tailleIcones/6)];
                [_prec1 setFrame:CGRectMake(20, 20 + tailleIcones/6, format.width - 40,-30 + (format.height/2 - 60)/2) ];
                
                
                [_label0 setFrame:CGRectMake(20, 20 + (format.height/2 - 60)/2, tailleIcones, tailleIcones/6)];
                [_prec0 setFrame:CGRectMake(20, 20 + tailleIcones/6 + (format.height/2 - 60)/2 , format.width - 40,-30 + (format.height/2 - 60)/2)];
                break;
            case 2 : // Diviser par 3
                [_label2 setFrame:CGRectMake(20, 20, tailleIcones, tailleIcones/6)];
                [_prec2 setFrame:CGRectMake(20, 20 + tailleIcones/6, format.width - 40,-30 + (format.height/2 - 60)/3) ];
                
                [_label1 setFrame:CGRectMake(20, 20 + (format.height/2 - 60)/3, tailleIcones, tailleIcones/6)];
                [_prec1 setFrame:CGRectMake(20, 20 + tailleIcones/6 + (format.height/2 - 60)/3 , format.width - 40,-30 + (format.height/2 - 60)/3)];
                
                [_label0 setFrame:CGRectMake(20, 20 + 2*(format.height/2 - 60)/3, tailleIcones, tailleIcones/6)];
                [_prec0 setFrame:CGRectMake(20, 20 + tailleIcones/6 + 2*(format.height/2 - 60)/3 , format.width - 40,-30 + (format.height/2 - 60)/3)];
                break;
            default: //Diviser par 4;
                [_label3 setFrame:CGRectMake(20, 20, tailleIcones, tailleIcones/6)];
                [_prec3 setFrame:CGRectMake(20, 20 + tailleIcones/6, format.width - 40,-30 + (format.height/2 - 60)/4) ];
                
                [_label2 setFrame:CGRectMake(20, 20 + (format.height/2 - 60)/4, tailleIcones, tailleIcones/6)];
                [_prec2 setFrame:CGRectMake(20, 20 + tailleIcones/6 + (format.height/2 - 60)/4 , format.width - 40,-30 + (format.height/2 - 60)/4)];
                
                [_label1 setFrame:CGRectMake(20, 20 + 2*(format.height/2 - 60)/4, tailleIcones, tailleIcones/6)];
                [_prec1 setFrame:CGRectMake(20, 20 + tailleIcones/6 + 2*(format.height/2 - 60)/4 , format.width - 40,-30 + (format.height/2 - 60)/4)];
                
                [_label0 setFrame:CGRectMake(20, 20 + 3*(format.height/2 - 60)/4, tailleIcones, tailleIcones/6)];
                [_prec0 setFrame:CGRectMake(20, 20 + tailleIcones/6 + 3*(format.height/2 - 60)/4 , format.width - 40,-30 + (format.height/2 - 60)/4)];
        }
        
        
        [_labelR setFrame:CGRectMake(20, 20 + format.height/2 - 50, tailleIcones, tailleIcones/6)];
        [_sldrR setFrame:CGRectMake(20, 30 + tailleIcones/6 + format.height/2 - 50, format.width - 40, tailleIcones/6)];
        
        [_labelV setFrame:CGRectMake(20, 30 + format.height/2 - 50 + 2*tailleIcones/6, tailleIcones, tailleIcones/6)];
        [_sldrV setFrame:CGRectMake(20, 40 + tailleIcones/6 + format.height/2 - 50 + 2*tailleIcones/6, format.width - 40, tailleIcones/6)];
        
        [_labelB setFrame:CGRectMake(20, 40 + format.height/2 - 50 + 4*tailleIcones/6, tailleIcones, tailleIcones/6)];
        [_sldrB setFrame:CGRectMake(20, tailleIcones/6 + format.height/2 + 4*tailleIcones/6, format.width - 40, tailleIcones/6)];
        
        
        [_btnMem setFrame:CGRectMake(20, tailleIcones + format.height/2 + tailleIcones/12, format.width - 40, tailleIcones/6)];
        [_btnRaz setFrame:CGRectMake(20, tailleIcones + format.height/2 + 2*tailleIcones/6, format.width - 40 , tailleIcones/6)];
        
        
        [_swtchWeb setFrame:CGRectMake(20, format.height - 40,tailleIcones/6,tailleIcones/6)];
        [_labelWeb setFrame:CGRectMake(20 + tailleIcones/2.5, format.height - 40, tailleIcones, tailleIcones/6)];
    }else{
        NSLog(@"LANDSCAPE");
        int staticLargeur = (format.width/2-40);
        int staticHauteur = (tailleIcones/6);
        int paddingHauteur = 25;
        
        switch (_nbMemoriser) {
            case 0:
                //trololo
                [_label0 setFrame:CGRectMake(paddingHauteur, paddingHauteur , staticLargeur, staticHauteur)];
                [_prec0 setFrame:CGRectMake(paddingHauteur, (1.5)*paddingHauteur + staticHauteur, staticLargeur,format.height/2+2*staticHauteur)];
                break;
                
            case 1:
                // Diviser par 2
                [_label1 setFrame:CGRectMake(paddingHauteur, paddingHauteur , staticLargeur, staticHauteur)];
                [_prec1 setFrame:CGRectMake(paddingHauteur, (1.2)*paddingHauteur + staticHauteur, staticLargeur,format.height/4)];
                
                [_label0 setFrame:CGRectMake(paddingHauteur, (1.4)*paddingHauteur + staticHauteur + format.height/4, staticLargeur, staticHauteur) ];
                [_prec0 setFrame:CGRectMake(paddingHauteur, (2)*paddingHauteur + staticHauteur + format.height/4 , staticLargeur,format.height/4)];
                break;
            case 2 : // Diviser par 3
                [_label2 setFrame:CGRectMake(paddingHauteur, paddingHauteur/2 , staticLargeur, staticHauteur)];
                [_prec2 setFrame:CGRectMake(paddingHauteur, (1.2)*paddingHauteur/2 + staticHauteur, staticLargeur,format.height/6)];
                
                [_label1 setFrame:CGRectMake(paddingHauteur, (1.4)*paddingHauteur/2 + staticHauteur + format.height/6, staticLargeur, staticHauteur) ];
                [_prec1 setFrame:CGRectMake(paddingHauteur, (1.6)*paddingHauteur/2 + 2*staticHauteur + format.height/6 , staticLargeur,format.height/6)];
                [_label0 setFrame:CGRectMake(paddingHauteur, (1.8)*paddingHauteur/2 + 2*staticHauteur + 2* format.height/6, staticLargeur, staticHauteur)];
                [_prec0 setFrame:CGRectMake(paddingHauteur, (2)*paddingHauteur/2 + 3*staticHauteur + 2*format.height/6 , staticLargeur,format.height/6)];
                break;
            default: //Diviser par 4;
                [_label3 setFrame:CGRectMake(paddingHauteur, paddingHauteur/2 , staticLargeur, staticHauteur)];
                [_prec3 setFrame:CGRectMake(paddingHauteur, (1.2)*paddingHauteur/2 + staticHauteur, staticLargeur,format.height/8)];
                
                [_label2 setFrame:CGRectMake(paddingHauteur, (1.4)*paddingHauteur/2 + staticHauteur + format.height/8, staticLargeur, staticHauteur) ];
                [_prec2 setFrame:CGRectMake(paddingHauteur, (1.6)*paddingHauteur/2 + 2*staticHauteur + format.height/8 , staticLargeur,format.height/8)];
                
                [_label1 setFrame:CGRectMake(paddingHauteur, (1.8)*paddingHauteur/2 + 2*staticHauteur + 2* format.height/8, staticLargeur, staticHauteur)];
                [_prec1 setFrame:CGRectMake(paddingHauteur, (2)*paddingHauteur/2 + 3*staticHauteur + 2*format.height/8 , staticLargeur,format.height/8)];

                [_label0 setFrame:CGRectMake(paddingHauteur, (2.2)*paddingHauteur/2 + 3*staticHauteur + 3*format.height/8, staticLargeur, staticHauteur)];
                [_prec0 setFrame:CGRectMake(paddingHauteur, (2.3)*paddingHauteur/2 + 4*staticHauteur + 3*format.height/8 , staticLargeur,format.height/8)];
        }
        
        [_labelR setFrame:CGRectMake(format.width/2+paddingHauteur, paddingHauteur , staticLargeur, staticHauteur)];
        [_sldrR setFrame:CGRectMake(format.width/2 +paddingHauteur, staticHauteur + 2*paddingHauteur, staticLargeur, staticHauteur)];
        
        [_labelV setFrame:CGRectMake(format.width/2+paddingHauteur, staticHauteur*2 + paddingHauteur*3, staticLargeur, staticHauteur)];
        [_sldrV setFrame:CGRectMake(format.width/2 +paddingHauteur,  staticHauteur*3 + paddingHauteur*4, staticLargeur, staticHauteur)];
        
        [_labelB setFrame:CGRectMake(format.width/2+paddingHauteur, staticHauteur*4 + paddingHauteur*5, staticLargeur, staticHauteur)];
        [_sldrB setFrame:CGRectMake(format.width/2 +paddingHauteur,  staticHauteur*5 + paddingHauteur*6, staticLargeur, staticHauteur)];
        
        
        [_btnMem setFrame:CGRectMake(20, staticHauteur*6 + paddingHauteur*7, staticLargeur , staticHauteur)];
        [_btnRaz setFrame:CGRectMake(format.width/2 +paddingHauteur, staticHauteur*6 + paddingHauteur*7, staticLargeur , staticHauteur)];
        
        
        [_swtchWeb setFrame:CGRectMake(20, format.height - 40,staticLargeur,staticHauteur)];
        [_labelWeb setFrame:CGRectMake(20 + staticLargeur/4, format.height - 30, (tailleIcones)/2, tailleIcones/6)];
    }
    
}

- (void)drawRect:(CGRect)rect {
    [self dessineDansFormat:rect.size];
}

@end
