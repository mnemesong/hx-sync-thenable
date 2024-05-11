# hx-sync-thenable
Class syncronus implemepts Thenable and Helpers for them.
See details of Thenable interfaces at https://lib.haxe.org/p/hx-thenable/


## API

### SyncThenable.hx
```haxe
package hxSyncThenable;

import haxe.Exception;
import result.Result;
import hxThenable.Thenable;

/**
	Sync executing thenable with execution errors catching
	see hxThenable.Themable declaration
**/
class SyncThenable<A> implements Thenable<A> {

	public var v( default, null ) : Result<A, Exception>;

	public function new(
		v : Result<A, Exception>
	) {...}

	public function map<B>( f : A -> B ) : SyncThenable<B> {...}

	public function then<B>( f : A -> Thenable<B> ) : SyncThenable<B> {...}
}

```

### SyncThenableHelper.hx
```haxe
package hxSyncThenable;

import result.Result;
import haxe.Exception;

/**
	Helper to work operations with SyncThenables
**/
class SyncThenableHelper {

	/**
		Lift value to SyncThenable context
	**/
	public static function lift<A>( v : A ) : SyncThenable<A> {...}

	/**
		Await ready and success of all thenables and convert them values to array of
		same count, as a given array. 
	**/
	public static function all<A>(
		thens : Array<SyncThenable<A>>
	) : SyncThenable<Array<A>> {...}

	/**
		Await ready and of all thenables and convert only success of  them values to array. 
	**/
	public static function some<A>(
		thens : Array<SyncThenable<A>>
	) : SyncThenable<Array<A>> {...}

	/**
		Await ready of first success thenable and return its value as a thenable.
	**/
	public static function any<A>(
		thens : Array<SyncThenable<A>>
	) : SyncThenable<A> {...}

	/**
		Executes procedure and lift result to Thenable context
	**/
	public static function exec<A>( f : () -> A ) : SyncThenable<A> {...}
}

```