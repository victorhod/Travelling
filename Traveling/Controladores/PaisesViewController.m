//
//  PaisesViewController.m
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import "PaisesViewController.h"

#define URL_PAISES @"http://sslapidev.mypush.com.br/world/countries/active"
#define FILENAME @"paises.dat"

@interface PaisesViewController ()

@end

@implementation PaisesViewController
@synthesize collectionCountries, activityIndicator;

NSMutableDictionary *dictPaises;
NSData *dados;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.collectionCountries.dataSource = self;
    self.collectionCountries.delegate = self;
    
    dictPaises = [[NSMutableDictionary alloc]init];
    dados = [[NSData alloc]init];
    [self verificaPaises];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [collectionCountries reloadData];
}

-(void)refreshCountries{
    
    ListaPaisesAsyncHelper *request = [[ListaPaisesAsyncHelper alloc]init];
    
    [request setDelegate:self];
    
    [activityIndicator startAnimating];
    
    //Dispara Requisição
    [request doGet:URL_PAISES];

}

-(void)verificaPaises{
//
//    dados = [Utilitarios readFromPlistFile:FILENAME];
//    
//    if(dados != nil){
//        NSLog(@"Arquivos Encontados. Carregando...");
//        arrayPais = [self parserJSON:dados];
//        
//    }else{
          NSLog(@"Arquivos Não Encontrados, Buscando...");
        [self refreshCountries];
    //}
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [Utilitarios myStaticArray].count;
}

/**
 * Recebe a imagem da bandeira, nome, se foi visitado ou não e preenche no collection
 * @Rafael Rezende Machado (rafael.rezendem@hotmail.com)
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:50];
    UIImageView *check = (UIImageView *)[cell viewWithTag:75];
    
    Pais *paisCell=nil;
    paisCell =[[Utilitarios myStaticArray] objectAtIndex:indexPath.row];
    label.text = paisCell.shortname;
    [recipeImageView sd_setImageWithURL:[NSURL URLWithString:paisCell.bandeira] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    if([paisCell.visitado isEqualToString:@"true"]){
        check.hidden = NO;
        
    }else{
        check.hidden = YES;
    }
    return cell;
}
/**
 * Métado que recebe toque da célula, e direciona para a tela de detalhes e passa o país selecionado
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //Recupera indice da linha selecionada.
    NSInteger linha = indexPath.row;
    
    Pais *pais = [[Utilitarios myStaticArray] objectAtIndex:linha];
    
    VisitouViewController *detalhes = [[VisitouViewController alloc] init];
    
    NSString *nomeStoryboard = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:nomeStoryboard bundle: nil];
    detalhes = [storyboard instantiateViewControllerWithIdentifier:@"VisitouViewController"];
    
    
    detalhes.paisDetalhes = pais;
    detalhes.arrayPaisDetalhes = [Utilitarios myStaticArray];
    
    [self.navigationController pushViewController:detalhes animated:YES];
    
    
}

/**
 *(Português) Ação 'parserJSON', Executa o Parser dos dados Retornados em JSON.
 * requisição.
 *
 *(English) Action 'parserJSON' Runs the Parser of Returnees data in JSON.
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param "NSData".
 * @return NSMutableArray.
 */
-(void)parserJSON:(NSData *)data{
    
    if(!data || [data length] == 0){
        NSLog(@"Nenhum dado encontrado");
    }
    
    //Inicia o Parser do JSON.
    SBJsonParser *jsonParser = [[SBJsonParser alloc]init];
    
    //Carrega NSData em um Dictionary.
    NSDictionary *dictPaises = (NSDictionary *)[jsonParser objectWithData:data];
    
    
    @try{
        
        //O valor do País pesquisado é lido de um NSDictionary.
        for(NSDictionary *elemento in dictPaises){
            
            Pais *paisAtual = [[Pais alloc]init];
            [paisAtual setIdPais: [NSString stringWithFormat:@"%@",[elemento valueForKey:@"id"]]];
            [paisAtual setShortname:[elemento valueForKey:@"shortname"]];
            [paisAtual setIso:[elemento valueForKey:@"iso"]];
            [paisAtual setLongname:[elemento valueForKey:@"longname"]];
            [paisAtual setCallingCode:[NSString stringWithFormat:@"%@",[elemento valueForKey:@"callingCode"]]];
            [paisAtual setStatus:[NSString stringWithFormat:@"%@",[elemento valueForKey:@"status"]]];
            [paisAtual setCulture:[elemento valueForKey:@"culture"]];
            [paisAtual setSelected:@"false"];
            
            NSString *urlString = [NSString stringWithFormat:@"http://sslapidev.mypush.com.br/world/countries/%@/flag", paisAtual.idPais];
            
            [paisAtual setBandeira:urlString];
            
            [[Utilitarios myStaticArray] addObject:paisAtual];
           
        }
        
//        BOOL SUCCESS = [Utilitarios writeToPlistFile:FILENAME dados:data];
//        
//        if(SUCCESS)
//            NSLog(@"Arquivos Gravados !");
        
    [self.collectionCountries reloadData];
        
    
        
    } @catch (NSException *exception) {
        
        [Utilitarios alerta:@"Ocorreu um erro ao pesquisar os Países desejados, Por favor tente novamente mais tarde !."];
    }
    
}


-(void)requestEndWithData:(NSData *)data{
    
    [activityIndicator stopAnimating];
    
    if(data && [data length] > 0){
       [self parserJSON:data];
    }
    
    if([Utilitarios myStaticArray] && [[Utilitarios myStaticArray] count] > 0){
        [self.collectionCountries reloadData];
        
    }else{
        [Utilitarios alerta:@"Nenhum País encontrado." ];
    }
    
}

//Erro
-(void)requestEndWithError:(NSError *)error{
    
}




@end
