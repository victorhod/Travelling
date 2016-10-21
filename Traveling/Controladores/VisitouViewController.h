//
//  VisitouViewController.h
//  Traveling
//
//  Created by Etica on 21/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pais.h"
#import "Utilitarios.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface VisitouViewController : UIViewController <UIAlertViewDelegate>{
    
    NSDate *dataAtual;
    int  validaData;

}

@property (weak, nonatomic)  Pais *paisDetalhes;
@property (weak, nonatomic) NSMutableArray *arrayPaisDetalhes;
@property (weak, nonatomic) IBOutlet UILabel *nomeCompleto;
@property (weak, nonatomic) IBOutlet UIImageView *bandeiraPais;
@property (weak, nonatomic) IBOutlet UILabel *codigoPais;
@property (weak, nonatomic) IBOutlet UISwitch *switchVisitou;
@property (weak, nonatomic) IBOutlet UITextField *txtData;
@property (weak, nonatomic) IBOutlet UIView *viewData;
@property (weak, nonatomic) IBOutlet UIDatePicker *selecionarData;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btCancelar:(id)sender;
- (IBAction)btSelecionar:(id)sender;
- (IBAction)btConfirmar:(id)sender;

@end
