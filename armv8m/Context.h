#ifndef CONTEXT_H
#define CONTEXT_H


#include <stdint.h>


#ifdef __cplusplus
extern "C"
{
#endif


typedef struct
{

} Context;


extern unsigned gNestLayer;


void saveContext(const Context* context);
void recoverContext(Context* context);


#ifdef __cplusplus
}
#endif


#endif
