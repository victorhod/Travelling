//
//  Pais.h
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pais : NSObject{
    
    NSString *idPais;
    NSString *iso;
    NSString *shortname;
    NSString *longname;
    NSString *callingCode;
    NSString *status;
    NSString *culture;
    NSString *bandeira;
    NSString *visitado;
    NSString *date;
    NSString *selected;
}



@property (nonnull, retain) NSString *idPais;
@property (nonnull, retain) NSString *iso;
@property (nonnull, retain) NSString *shortname;
@property (nonnull, retain) NSString *longname;
@property (nonnull, retain) NSString *callingCode;
@property (nonnull, retain) NSString *status;
@property (nonnull, retain) NSString *culture;
@property (nonnull, retain) NSString *bandeira;
@property (nonnull, retain) NSString *visitado;
@property (nonnull, retain) NSString *date;
@property (nonnull, retain) NSString *selected;
@end
