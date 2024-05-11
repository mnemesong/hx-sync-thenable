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
	) {
		this.v = v;
	}

	public function map<B>( f : A -> B ) : SyncThenable<B> {
		try {
			switch( this.v ) {
				case Ok( v ):
					return new SyncThenable( Ok( f( v ) ) );
				case Error( e ):
					return new SyncThenable( Error( e ) );
			}
		} catch( e ) {
			return cast new SyncThenable( Error( e ) );
		}
	}

	public function then<B>( f : A -> Thenable<B> ) : SyncThenable<B> {
		try {
			switch( this.v ) {
				case Ok( v ):
					return cast f( v );
				case Error( e ):
					return new SyncThenable( Error( e ) );
			}
		} catch( e ) {
			return cast new SyncThenable( Error( e ) );
		}
	}
}
