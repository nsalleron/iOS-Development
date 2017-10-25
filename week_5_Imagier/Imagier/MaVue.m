//
//  MaVue.m
//  Imagier
//
//  Created by Nicolas Salleron on 16/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import "MaVue.h"
#import "ViewController.h"

@implementation MaVue



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [self DessineDansFormat:rect.size];
}


- (void)setParallaxe {
        /* Parallaxe */
          UIInterpolatingMotionEffect *effectV = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        [effectV setMinimumRelativeValue:@(-50)]; //Ask to Kordon
        [effectV setMaximumRelativeValue:@(50)];
        UIInterpolatingMotionEffect *effectH = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        [effectH setMinimumRelativeValue:@(-50)];
        [effectH setMaximumRelativeValue:@(50)];
        [_monImageView addMotionEffect:effectH];
        [_monImageView addMotionEffect:effectV];
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        _indexTableau = 0;
        
        /* Init de la toolbar */
        _tb = [[UIToolbar alloc] initWithFrame:frame ];
        
        _back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.superview action:@selector(changeImage:)];
        _foward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.superview action:@selector(changeImage:)];
        _text = [[UIBarButtonItem alloc] initWithTitle:@"Image 1" style:UIBarButtonItemStyleDone target:nil action:nil];
        [_text setTintColor:[UIColor blackColor]];
        _space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        _tabTb = [NSArray arrayWithObjects:_back,_space,_text,_space,_foward, nil];
        [_tb setItems:_tabTb];
        
        /* Init du slider */
        _sldrImage = [[UISlider alloc] init];
        [_sldrImage setTintColor:[UIColor blueColor]];
        [_sldrImage setMinimumValue:0.05];
        [_sldrImage setMaximumValue:1.0];
        [_sldrImage addTarget:self.superview action:@selector(changeZoom) forControlEvents:UIControlEventValueChanged];
        
        /* Init du label */
        _labelZoom = [[UILabel alloc]init];
        [_labelZoom setText:@""];
        [_labelZoom setTextColor:[UIColor whiteColor]];
        [_labelZoom setBackgroundColor:[UIColor grayColor]];
        
        /* ScrollView */
        _scrollV = [[UIScrollView alloc] initWithFrame:frame];
        [_scrollV setBackgroundColor:[UIColor whiteColor]];
        [_scrollV setMaximumZoomScale:1.0];
        [_scrollV setMinimumZoomScale:0.05];
        [_scrollV setDelegate:self];
        [_scrollV setZoomScale:0.2 animated:YES];
        [_scrollV addSubview:_monImageView];
        
        /* Ajout dans view */
        [self addSubview:_scrollV];
        [self addSubview:_tb];
        [self addSubview:_sldrImage];
        [self addSubview:_labelZoom];
        
        [_monImageView release];
        [_scrollV release];
        [_sldrImage release];
        [_labelZoom release];
        [self DessineDansFormat:frame.size];
        [self changeImage];
    }
    return self;
}


- (void) DessineDansFormat:(CGSize) frame{
    
    [_tb setFrame:CGRectMake(0, 0, frame.width, 10 + 40)];
    [_labelZoom setFrame:CGRectMake(10, 50, frame.width/6, 40)];
    [_scrollV setFrame:CGRectMake(-50, 0, frame.width+50, frame.height+50-40)];
    [_sldrImage setFrame:CGRectMake(20, frame.height-70, frame.width-40, 50)];
    
}

- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _monImageView;
}

- (void) changeImage{
    
    NSLog(@"valeur de l'index : %d",_indexTableau);
    
    UIImage *imagedep = [self returnImage:_indexTableau];
    NSLog(@"=> %@",[imagedep description]);
    
    [_monImageView removeFromSuperview];
    _monImageView = [[UIImageView alloc] initWithImage:imagedep];
    [_scrollV addSubview:_monImageView];
    [_scrollV setZoomScale:0.2 animated:YES];
    [_monImageView release];
    [_text setTitle:[[NSString alloc] initWithFormat:@"Image %d",_indexTableau+1]];
    [_sldrImage setValue:0.2];
    [self setParallaxe];
}

- (UIImage*) returnImage:(int) value{
    NSString *image = [[NSString alloc] initWithFormat:@"%@/photo-%d.jpg",[[NSBundle mainBundle] resourcePath],value];
    //NSLog(@"%@",image);
    UIImage *tmp = [UIImage imageWithContentsOfFile:image];
    return tmp;
}

- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"scale : %f",scale);
    [_scrollV setZoomScale:scale];
    [_labelZoom setText:[NSString stringWithFormat:@"%d%%",(int) (scale*100)]];
}

@end
