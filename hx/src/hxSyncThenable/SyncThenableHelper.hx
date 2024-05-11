package hxSyncThenable;

import result.Result;
import haxe.Exception;

using Lambda;

/**
	Helper to work operations with SyncThenables
**/
class SyncThenableHelper {

	/**
		Lift value to SyncThenable context
	**/
	public static function lift<A>( v : A ) : SyncThenable<A> {
		return new SyncThenable( Ok( v ) );
	}

	/**
		Await ready and success of all thenables and convert them values to array of
		same count, as a given array. 
	**/
	public static function all<A>(
		thens : Array<SyncThenable<A>>
	) : SyncThenable<Array<A>> {
		try {
			var vals = thens.fold( (
				el : SyncThenable<A>,
				acc : { oks : Array<A>, errs : Array<Exception> }
			) -> {
				switch el.v {
					case Ok( v ):
						return ( { oks : acc.oks.concat( [v] ), errs : acc.errs } );
					case Error( e ):
						return ( { oks : acc.oks, errs : acc.errs.concat( [e] ) } );
				}
			}, { oks : [], errs : [] } );
			if ( vals.errs.length > 0 ) {
				return new SyncThenable( Error( vals.errs[0] ) );
			}
			return new SyncThenable( Ok( vals.oks ) );
		} catch( e ) {
			return new SyncThenable( Error( e ) );
		}
	}

	/**
		Await ready and of all thenables and convert only success of  them values to array. 
	**/
	public static function some<A>(
		thens : Array<SyncThenable<A>>
	) : SyncThenable<Array<A>> {
		try {
			var vals = thens.fold( (
				el : SyncThenable<A>,
				acc : { oks : Array<A> }
			) -> {
				switch el.v {
					case Ok( v ):
						return ( { oks : acc.oks.concat( [v] ) } );
					case Error( e ):
						return ( { oks : acc.oks } );
				}
			}, { oks : [] } );
			return new SyncThenable( Ok( vals.oks ) );
		} catch( e ) {
			return new SyncThenable( Error( e ) );
		}
	}

	/**
		Await ready of first success thenable and return its value as a thenable.
	**/
	public static function any<A>(
		thens : Array<SyncThenable<A>>
	) : SyncThenable<A> {
		try {
			var vals = thens.fold( (
				el : SyncThenable<A>,
				acc : { oks : Array<A>, errs : Array<Exception> }
			) -> {
				switch el.v {
					case Ok( v ):
						return ( { oks : acc.oks.concat( [v] ), errs : acc.errs } );
					case Error( e ):
						return ( { oks : acc.oks, errs : acc.errs.concat( [e] ) } );
				}
			}, { oks : [], errs : [] } );
			if ( vals.oks.length > 0 ) {
				return new SyncThenable( Ok( vals.oks[0] ) );
			}
			return new SyncThenable( Error( vals.errs[0] ) );
		} catch( e ) {
			return new SyncThenable( Error( e ) );
		}
	}

	/**
		Executes procedure and lift result to Thenable context
	**/
	public static function exec<A>( f : () -> A ) : SyncThenable<A> {
		try {
			return new SyncThenable( Ok( f() ) );
		} catch( e ) {
			return new SyncThenable( Error( e ) );
		}
	}
}
