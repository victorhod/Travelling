//
//  HttpAsyncHelperDelegate.h
//  Carros
//
//  Created by Etica on 11/07/16.
//  Copyright © 2016 FVRR. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpAsyncHelperDelegate <NSObject>
@required

//Ok
-(void)requestEndWithData:(NSData *)data;

//Erro
-(void)requestEndWithError:(NSError *)error;

@end
