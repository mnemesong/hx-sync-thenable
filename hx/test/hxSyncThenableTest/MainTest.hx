package hxSyncThenableTest;

class MainTest {

	public static function main() {
		var service = new TestService( new TestIO() );
		service.mySimpleScript();
		Sys.println( "Success" );
	}
}
