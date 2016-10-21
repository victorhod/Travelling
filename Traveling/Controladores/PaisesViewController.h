//
//  PaisesViewController.h
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pais.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ListaPaisesAsyncHelper.h"
#import "SBJson.h"
#import <PINCache.h>
#import "Utilitarios.h"
#import "VisitouViewController.h"

@interface PaisesViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>{
    
    NSMutableArray*arrayImagens;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionCountries;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
