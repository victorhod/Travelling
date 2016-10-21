//
//  VisitouViewController.m
//  Traveling
//
//  Created by Etica on 21/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import "VisitouViewController.h"

#define FILENAME @"paises.dat"


@implementation VisitouViewController
@synthesize txtData, bandeiraPais, codigoPais, switchVisitou, nomeCompleto, selecionarData, viewData, arrayPaisDetalhes, paisDetalhes;

int cont = 0;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [viewData setHidden:YES];

      self.navigationItem.title = paisDetalhes.shortname;
    
    nomeCompleto.text = paisDetalhes.longname;
    
    [bandeiraPais sd_setImageWithURL:[NSURL URLWithString:paisDetalhes.bandeira] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    codigoPais.text = [NSString stringWithFormat:@"Código de área: %@", paisDetalhes.callingCode];
    txtData.text = paisDetalhes.date;
    
    if([paisDetalhes.visitado isEqualToString:@"true"]){
        [switchVisitou setOn:YES];
    }
    
    //Inicializa Scroll
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentSize =CGSizeMake(0, 366);
    
    self.selecionarData.maximumDate = [NSDate date];
}


- (IBAction)btCancelar:(id)sender {
    [viewData setHidden:YES];
}

- (IBAction)btSelecionar:(id)sender {
    
    dataAtual =[selecionarData date];
    [viewData setHidden:YES];
    
    //converte date para string e seta no textField
    [txtData setText:[Utilitarios converteDataLocalString:dataAtual]];
}

- (IBAction)btConfirmar:(id)sender {


    
    if([self validaCamposObrigatorios]){
        
        for(Pais *elemento in [Utilitarios myStaticArray]){
            
            if([paisDetalhes.idPais isEqualToString:elemento.idPais]){
                [elemento setDate:txtData.text];
                [elemento setVisitado:@"true"];
                
                [arrayPaisDetalhes replaceObjectAtIndex:cont withObject:elemento];
                
                cont++;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK!"
                                                                message:@"Registro efetuado com sucesso"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                if(self.navigationController){
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
                }
                break;
            }
           
        }
        
    }
}

-(BOOL) validaCamposObrigatorios {
    
    NSMutableString *camposObrigatorios = [[NSMutableString alloc] initWithString:@""];
    BOOL validaCampos = YES;
    
    if(![switchVisitou isOn]) {
        [camposObrigatorios
         appendString:@"Marque o país como visitado!\n"];
        validaCampos = NO;
    }
    
    if([txtData.text length] ==0 ) {
        [camposObrigatorios
         appendString:@"Informe a data da visita!\n"];
        validaCampos = NO;
    }
    if(!validaCampos){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção!"
                                                        message:camposObrigatorios
                                                       delegate:self
                              
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    return  validaCampos;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [viewData setHidden:NO];
    [self.view endEditing:YES];
}


@end
