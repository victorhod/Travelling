//
//  PaisesVisitadosViewController.m
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import "PaisesVisitadosViewController.h"

@interface PaisesVisitadosViewController ()

@end

@implementation PaisesVisitadosViewController
@synthesize tableContries;

UIBarButtonItem *editTableButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    editTableButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"Editar"
                       style:UIBarButtonItemStyleDone
                       target:self
                       action:@selector(editTable:)];
    
    self.navigationItem.rightBarButtonItem = editTableButton;

    [self atualizaTable];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self atualizaTable];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)atualizaTable{
    pais = [[NSMutableArray alloc]init];
    paisArray = [[NSMutableArray alloc]init];
    pais =  [Utilitarios myStaticArray];
    
    //Verifica paises visitados
    for(Pais *elemento in pais){
        if([elemento.visitado isEqualToString:@"true"]){
            [paisArray addObject:elemento];
        }
    }
      [tableContries reloadData];
}

-(IBAction)editTable:(id)sender{
    
    [tableContries setEditing:![[self tableContries] isEditing] animated:YES];
}


#pragma mark - TableView

/**
 *(Português) Metodo 'numberOfSectionsInTableView', Retorna quantidade de sessões para criar na tabela.
 *
 *(English) Method 'numberOfSectionsInTableView' Returns number of sessions to create the table.
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param Object "UITableView".
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

/**
 *(Português) Metodo 'numberOfRowsInSection', Retorna quantidade de linhas para criar na tabela, que é a
 * quantidade de Filmes.
 *
 *(English) Method 'numberOfRowsInSection' Returns number of lines to create the table, which is
 * Amount of movies.
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param Object "UITableView", "NSInteger".
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [paisArray count];
}


/**
 *(Português) Metodo 'cellForRowAtIndexPath', Retorna a célula que vai ser o conteúdo para a linha solicitada.
 *
 *(English) Method 'cellForRowAtIndexPath', Returns the cell that will be the content for the requested line.
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param Object "UITableView", "NSIndexPath".
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[self.tableContries dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];    }
    
    //Recupera indice da linha selecionada.
    NSInteger linha = indexPath.row;
    
    Pais *paises;
    if([paisArray count] != 0){
        paises = [paisArray objectAtIndex:linha];
        [editTableButton setEnabled:YES];
        
        
        UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:51];
        [recipeImageView sd_setImageWithURL:[NSURL URLWithString:paises.bandeira] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:3];
        recipeNameLabel.text = paises.shortname;
        
        
    }
    
    return cell;
}


/**
 *(Português) Metodo 'didSelectRowAtIndexPath', Pega a célula selecionada da Tabela.
 * solicitada.
 *
 *(English) Method 'didSelectRowAtIndexPath', Grab the selected cell of the table.
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param Object "UITableView", "NSIndexPath".
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Recupera indice da linha selecionada.
    NSInteger linha = indexPath.row;
    
    Pais *paises = [paisArray objectAtIndex:linha];
    
    //Navega para a tela de detalhes.
    VisitouViewController *detalhes = [[VisitouViewController alloc]init];
    
    NSString *nomeStoryboard = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:nomeStoryboard bundle: nil];
    detalhes = [storyboard instantiateViewControllerWithIdentifier:@"VisitouViewController"];
    
    
    detalhes.paisDetalhes = paises;
    
    [self.navigationController pushViewController:detalhes animated:YES];
    
}

/**
 *(Português) Metodo 'canEditRowAtIndexPath', Retorna um booleano permitindo editarmos as células da tabela.
 * solicitada.
 *
 *(English) Method 'canEditRowAtIndexPath', Returns a boolean allowing we edit the table cells.
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param Object "UITableView", "NSIndexPath".
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/**
 *(Português) Metodo 'canEditRowAtIndexPath', No momento da edição identificamos através de métodos nativos
 * qual ação iremos tomar com a célula selecionada.
 *
 *(English) Method 'canEditRowAtIndexPath', At the time of issue identified through native methods what action
 * we will take to the selected cell
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br).
 * @param Object "UITableView", "NSIndexPath".
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSInteger linha = indexPath.row;
        
        Pais *paises = [paisArray objectAtIndex:linha];
        
        for(Pais *elementoPais in paisArray){
            if([elementoPais.idPais isEqualToString:paises.idPais]){
                if ([ elementoPais.visitado isEqualToString:@"true"]) {
                    
                    [elementoPais setVisitado:@"false"];
                }
            }
            
            [pais replaceObjectAtIndex:linha withObject:elementoPais];
            [paisArray removeObjectAtIndex:linha];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if([paisArray count] == 0){
            [editTableButton setEnabled:NO];
            
        }
    }
  }
}

@end
