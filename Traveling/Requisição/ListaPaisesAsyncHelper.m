//
//  HttpAsyncHelper.m
//  Carros
//
//  Created by Etica on 11/07/16.
//  Copyright © 2016 FVRR. All rights reserved.
//

#import "ListaPaisesAsyncHelper.h"
#import "HTTPAsyncHelperDelegate.h"

@implementation ListaPaisesAsyncHelper
@synthesize delegate;

/**
 * Este método executa o request do JSON em modo Assícrono , assim liberando a thread
 * principal para nao travar a tela do usuario e ocorrer problemas de processamento e também
 * por uma boa prática de programação. 
 * @author Victor Freitas (victor.alves@eticasolucoes.com.br)
 */
-(void)doGet:(NSString *)url{
    
    //Cria o NSMUtableData para receber o retorno.
    retornoHttp = [NSMutableData data];
    
    //Inicia a request HTTP, disparando de forma assícrona.
    //o Delegate:self indica que vamos receber os eventos nessa classe.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - HTTP

//Recebeu uma resposta do servidor
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [retornoHttp setLength:0];
}

//Recebeu Dados, então vamos adicionar no NSData.
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [retornoHttp appendData:data];
}

//Ocorreu um erro
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if(delegate){
        [delegate requestEndWithError:error];
    }
}

//Terminou a requisição
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //Avisa o delegate que a requisição terminou.
    if(delegate){
        [delegate requestEndWithData:retornoHttp];
    }
}
@end
