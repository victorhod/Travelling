//
//  PaisesVisitadosViewController.h
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pais.h"
#import "Utilitarios.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "VisitouViewController.h"


@interface PaisesVisitadosViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *paisArray;
    NSMutableArray *pais;
}

@property (weak, nonatomic) IBOutlet UITableView *tableContries;

@end
