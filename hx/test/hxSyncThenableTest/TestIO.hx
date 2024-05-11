package hxSyncThenableTest;

import hxThenable.Thenable;
import hxSyncThenable.SyncThenableHelper;
import hxSyncThenable.SyncThenable;
import hxSyncThenableTest.TestService.ITestIO;

class TestIO implements ITestIO {

	public function new() {}

	public function lift<V>( v : V ) : SyncThenable<V> {
		return SyncThenableHelper.lift( v );
	}

	public function readLnInt() : SyncThenable<Int> {
		return SyncThenableHelper.exec(() -> {
			Sys.println( "Please input integer number:" );
			return Std.parseInt( Sys.stdin().readLine() );
		} );
	}

	public function printLnInt( i : Int ) : SyncThenable<{}> {
		return SyncThenableHelper.exec(() -> {
			Sys.println( "Output num: " + Std.string( i ) );
			return {};
		} );
	}

	public function all<V>( all : Array<Thenable<V>> ) : SyncThenable<Array<V>> {
		return SyncThenableHelper.all( cast all );
	}

	public function some<V>( all : Array<Thenable<V>> ) : Thenable<Array<V>> {
		return SyncThenableHelper.some( cast all );
	}

	public function any<V>( all : Array<Thenable<V>> ) : Thenable<V> {
		return SyncThenableHelper.any( cast all );
	}
}
