/*******************************************************************************
	nsenumerate.h
		Copyright (c) 2003-2007 Jonathan 'Wolf' Rentzsch: <http://rentzsch.com>
		Some rights reserved: <http://opensource.org/licenses/mit-license.php>

	***************************************************************************/

#import <Foundation/Foundation.h>
#import <objc/objc-api.h>

#if defined(OBJC_API_VERSION) && OBJC_API_VERSION >= 2
	#define	nsenumerate( CONTAINER, ITERATOR_TYPE, ITERATOR_SYMBOL )	\
		for (ITERATOR_TYPE *ITERATOR_SYMBOL in CONTAINER)

	#define	nsenumerat( CONTAINER, ITERATOR_SYMBOL )					\
		for (id ITERATOR_SYMBOL in CONTAINER)
#else
	#define nsenumerate_getEnumerator( TYPE, OBJ )				\
		(TYPE)([OBJ isKindOfClass:[NSEnumerator class]]			\
		? OBJ													\
		: [OBJ performSelector:@selector(objectEnumerator)])

	#define	nsenumerate( CONTAINER, ITERATOR_TYPE, ITERATOR_SYMBOL )			\
	for( ITERATOR_TYPE															\
		 *enumerator = nsenumerate_getEnumerator(ITERATOR_TYPE*, CONTAINER),	\
		 *ITERATOR_SYMBOL = [((NSEnumerator*) enumerator) nextObject];			\
		 ITERATOR_SYMBOL != nil;												\
		 ITERATOR_SYMBOL = [((NSEnumerator*) enumerator) nextObject] )

	#define	nsenumerat( CONTAINER, ITERATOR_SYMBOL )					\
	for( id																\
		 enumerator = nsenumerate_getEnumerator(id, CONTAINER),			\
		 ITERATOR_SYMBOL = [((NSEnumerator*) enumerator) nextObject];	\
		 ITERATOR_SYMBOL != nil;										\
		 ITERATOR_SYMBOL = [((NSEnumerator*) enumerator) nextObject] )
#endif
