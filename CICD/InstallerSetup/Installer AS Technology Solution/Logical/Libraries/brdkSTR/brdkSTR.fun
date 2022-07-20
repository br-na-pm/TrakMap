
FUNCTION brdkStrAppendUdintToA : DINT (*Appends an UDINT to the end of a string. $RETURN=length;Length of the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		value : UDINT; (*UDINT value to be converted.*)
		pString : UDINT; (*String pointer to source string.*)
		base : USINT; (*0,10 = decimal, 2 = binary, 16 = hex.*)
		position : DINT; (*Append position. Negative numbers will count from end of string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrAToDint : DINT (*Converts a string to a DINT type. $RETURN=value;DINT value.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		base : USINT; (*0,10 = decimal, 2 = binary, 16 = hex.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrAToUdint : UDINT (*Converts a string to an UDINT type. $RETURN=value;UDINT value.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		base : USINT; (*0,10 = decimal, 2 = binary, 16 = hex.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCat : UDINT (*Appends a copy of the source string to the end of the destination string. $RETURN=address;Address after the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination string pointer.*)
		pSource : UDINT; (*Source string pointer.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCatAtChar : DINT (*Appends a copy of the source string to the char position of the destination string. $RETURN=index;Index in destination string where the source string is appended. -1 if char is not found.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination string pointer.*)
		pSource : UDINT; (*Source string pointer.*)
		pChar : UDINT; (*Char pointer.*)
		direction : DINT; (*0 = first appearance of char, -1 = last appearance of char.*)
		greedy : BOOL; (*If true the source string is appended to the char position. If false the char is still present in the destination string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCharAt : USINT (*Returns the character at the specified index. $RETURN=coding;ASCII coding of the char.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		index : UDINT; (*Look up index.*)
		pChar : UDINT; (*Char pointer to char to look up.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCharCount : DINT (*Finds how many times a character appears in a string. $RETURN=count;Char count. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		pChar : UDINT; (*Pointer to search char.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCmp : DINT (*Compares character(s) from string1 to string2. $RETURN=result;0 means that the two string are equal.*)
	VAR_INPUT
		pString1 : UDINT; (*String1 pointer.*)
		pString2 : UDINT; (*String2 pointer.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCrc32 : UDINT (*Calculates a CRC32 checksum based on the input string. $RETURN=checksum;Checksum of the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrDintToA : DINT (*Converts a DINT into a STRING type. $RETURN=length;Length of the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		value : DINT; (*DINT value to be converted.*)
		pString : UDINT; (*String pointer to source string.*)
		base : USINT; (*0,10 = decimal, 2 = binary, 16 = hex.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrCpy : UDINT (*Copies a string to another string. $RETURN=address;Address after the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination string pointer.*)
		pSource : UDINT; (*Source string pointer.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrFill : DINT (*Inserts amount of character(s) to the specified position of the string. $RETURN=length;Length of the string. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		amount : DINT; (*Fill char amount.*)
		pChar : UDINT; (*Fill char. If 0 whitespace is used.*)
		position : DINT; (*Fill position. Negative numbers will count from end of string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrIndexOf : DINT (*Returns the index within this string of the first or last occurrence of the specified character. $RETURN=index;Index of the char. -1 if char is not found.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		pChar : UDINT; (*Char pointer to char to look up.*)
		direction : DINT; (*0 = search from left, -1 = search from right.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrInsertAtPos : DINT (*Inserts a string into another string at a specified position. $RETURN=length;Length of the string. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		pInsert : UDINT; (*String pointer to insert string.*)
		position : DINT; (*Insert position. Negative numbers will count from end of string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrLen : DINT (*Returns the number of characters in a string. Stops at \0. $RETURN=length;length of the string*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrMemCmp : DINT (*Compares amount of character(s) from area1 to area2. $RETURN=result;0 means that the two areas are equal.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pArea1 : UDINT; (*Area1 pointer.*)
		pArea2 : UDINT; (*Area2 pointer.*)
		amount : UDINT; (*Amount of character(s) to be comared.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrMemCpy : UDINT (*Copies amount of character(s) from source to destination. $RETURN=address;Address after the destination.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination pointer.*)
		pSource : UDINT; (*Source pointer.*)
		amount : UDINT; (*Amount of character(s) to be copied.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrMemMove : UDINT (*Moves amount of character(s) from source to destination. $RETURN=address;Address after the destination.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination pointer.*)
		pSource : UDINT; (*Source pointer.*)
		amount : UDINT; (*Amount of character(s) to be moved.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrMemSet : UDINT (*Fills amount of character(s) to destination. $RETURN=address;Address after the destination.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination pointer.*)
		value : USINT; (*Initialization value.*)
		amount : UDINT; (*Amount of character(s) to be initialized.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrMove : UDINT (*Moves a string to another string. $RETURN=address;Address after the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination string pointer.*)
		pSource : UDINT; (*Source string pointer.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrNCpy : UDINT (*Copies a string to another string. If the function encounters a null character in the source string, the function will add null characters to the destination string until amount character(s) have been written. $RETURN=address;Address after the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination string pointer.*)
		pSource : UDINT; (*Source string pointer.*)
		amount : UDINT; (*Amount of character(s) to be moved.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrRemove : UDINT (*Removes character(s) from a string from a specified position. $RETURN=address;Address after the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*Source string pointer.*)
		start : DINT; (*Index of where to start in the string. Negative numbers start from the end of the string.*)
		length : DINT; (*0 means to the end of the string. Negative length is subtracted from the end of the string. Is start is negative length is subtracted from the start of the string. *)
	END_VAR
END_FUNCTION

FUNCTION brdkStrRepeat : DINT (*Repeats a string a specified number of times. $RETURN=length;Length of the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		times : DINT; (*Number of times the string should be repeated.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrReplace : DINT (*Replaces some characters with some other characters in a string. $RETURN=number;Number of replacements done.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		pFind : UDINT; (*String pointer to find string.*)
		pReplace : UDINT; (*String pointer to replacement string:*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrReverse : DINT (*Reverses a string from start position to end position. $RETURN=count;Number of reverses done. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		startPosition : DINT; (*Start position. Must be a positive number and less than length.*)
		endPosition : DINT; (*End position. Must be less than length unless it's a negative numbers which will count from end of string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrReverseWords : DINT (*Reverses words in a string. $RETURN=count;Number of words reversed.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrSearch : DINT (*Searches a string for a specified string. $RETURN=position; Position of the match. -1 if no match.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		pSearchString : UDINT; (*String pointer to search string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrSlice : DINT (*Slices a part of a string. $RETURN=length;Length of the string. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		start : DINT; (*Start position.*)
		end : DINT; (*End position.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrSubStr : DINT (*Returns a part of a string. $RETURN=length;Length of the destination string. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDestination : UDINT; (*Destination string pointer.*)
		pSource : UDINT; (*Source string pointer.*)
		start : DINT; (*Index of where to start in the string. Negative numbers start from the end of the string.*)
		length : DINT; (*0 means to the end of the string. Negative length is subtracted from the end of the string. Is start is negative length is subtracted from the start of the string. *)
	END_VAR
END_FUNCTION

FUNCTION brdkStrToDec : DINT (*Converts a string of hexadecimal values to ASCII characters. $RETURN=length;Length of the string. -1 if error.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrToHex : DINT (*Converts a string of ASCII characters to hexadecimal values. $RETURN=length;Length of the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrToLowerCase : DINT (*Converts a string to lowercase letters. $RETURN=number;Number of characters changed.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrToUpperCase : DINT (*Converts a string to uppercase letters. $RETURN=number;Number of characters changed.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrToUpperCaseWords : DINT (*Convert the first character of each word to uppercase. (title()). $RETURN=number;Number of characters changed.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrTrim : DINT (*Removes whitespaces from a string. $RETURN=number;Number of whitespaces removed from string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pString : UDINT; (*String pointer to source string.*)
		direction : DINT; (*0 = both sides, 1 = left side only, -1 = right side only.*)
	END_VAR
END_FUNCTION

FUNCTION brdkStrUdintToA : DINT (*Converts an UDINT into a STRING type. $RETURN=length;Length of the string.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		value : UDINT; (*UDINT value to be converted.*)
		pString : UDINT; (*String pointer to source string.*)
		base : USINT; (*0,10 = decimal, 2 = binary, 16 = hex.*)
	END_VAR
END_FUNCTION
