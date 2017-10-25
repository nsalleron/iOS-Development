//
//  MaVue.h
//  Imagier
//
//  Created by Nicolas Salleron on 16/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaVue : UIView <UIScrollViewDelegate>

@property(readwrite,nonatomic,assign) UIToolbar *tb;
@property(readwrite,nonatomic,assign)UIBarButtonItem *back;
@property(readwrite,nonatomic,assign)UIBarButtonItem *space;
@property(readwrite,nonatomic,assign)UIBarButtonItem *text;
@property(readwrite,nonatomic,assign)UIBarButtonItem *foward;

@property(readwrite,nonatomic,assign)UIImageView *monImageView;
@property(readwrite,nonatomic,assign)UIScrollView *scrollV;

@property(readwrite,nonatomic,assign)UISlider *sldrImage;
@property(readwrite,nonatomic,assign)UILabel *labelZoom;

@property(readwrite,nonatomic,assign)NSArray<UIBarButtonItem*> *tabTb;

@property(readwrite,nonatomic,assign)int indexTableau;

- (void) changeImage;
- (void) DessineDansFormat:(CGSize) frame;
@end
