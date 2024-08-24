package backend.utils;

import sys.thread.Thread;

enum LogType
{
	INFO;
	WARN;
	ERROR;
	DEBUG;
}

class Log
{
	static function getNameFromCaller(c:Any):String
	{
		return Type.getClassName(Type.getClass(c));
	}

	overload extern inline public static function print(type:LogType, s:String)
	{ // Two overloads depending on how lazy you are
		Thread.create(() ->
		{ // Create a new thread so the game doesnt pause trying to print (like the normal trace)
			if (type == INFO)
				Sys.println('INFO: $s');
			if (type == WARN)
				Sys.println('WARNING: $s');
			if (type == ERROR)
				Sys.println('ERROR: $s');
			if (type == DEBUG)
				Sys.println('DEBUG: $s');
		});
	}

	overload extern inline public static function print(s:String)
	{
		Thread.create(() ->
		{
			Sys.println(s);
		});
	}
}
