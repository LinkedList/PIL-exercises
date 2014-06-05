/*
 *	Chapter 28, Exercise 6
 *
 * 	Do you think it is a good design to keep the transliteration table as part of the state of the library,
 * 	instead of being a parameter to transliterate?
 *
 *	Solution:
 * 	It's not a good idea. Consider a scenario where two parts of the code have their own tranliteration table.
 * 	One would reconfigure it for the other and vice versa.
 * 	Also race conditions could occur.
 */
