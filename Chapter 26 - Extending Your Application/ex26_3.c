/*
 *	Chapter 26, Exercise 3
 *
 *	Let us suppose a program that needs to monitor several weather stations.
 *	Internally, it uses a four-byte string to represent each station,
 *	and there is a configuration file to map each string to the actual URL of the
 *	corresponding station. A Lua configuration file could do this mapping in several
 *	ways:
 *
 *		a bunch of global vaiables, one for each station;
 *		one table mapping string codes to URLs;
 *		one function mapping string codes to URLs;
 *
 *	Discuss the pros and cons of each option, considering things like the total number of
 *	stations, the regularity of the URLs (e.g. there may be a formation rule from codes to
 *	URLs), the kind of users, etc.
 *
 *	Solution:
 *	global variables:
 *		+easy to use
 *		+visible by naked eye what the URL is
 *		-need to call lua_getglobal on every string
 *		-for bigger number of stations not really usable
 *
 *	one table
 *		+only one lua_getglobal
 *		=still same as global variables otherwise
 *
 *	function mapping codes to URLs
 *		-not really a config file
 *		-only usable if the URLs and string codes are somehow interchangealbe (regular)
 *		-might not be apparent of what url will the string code return
 *		=need to call getglobal on function name, push<argument> and pcall
 *		+ small definition for bigger number of stations
 *
 * 	function mapping codes to URLs with internal table
 * 		:same as above but has a internal table for irregular URLs that it checks first
 * 		best of two worlds probably
 *
 */
