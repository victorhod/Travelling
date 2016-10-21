//
//  HttpAsyncHelper.h
//  Carros
//
//  Created by Etica on 11/07/16.
//  Copyright © 2016 FVRR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPAsyncHelperDelegate.h"

@interface ListaPaisesAsyncHelper : NSObject <NSURLConnectionDataDelegate>{
    
    //Retorno do HTTP
    NSMutableData *retornoHttp;
    
    id <HttpAsyncHelperDelegate> delegate;
}

@property (retain) id delegate;

-(void) doGet:(NSString *)url;

@end
