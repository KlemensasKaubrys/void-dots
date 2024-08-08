//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{" ", "setxkbmap -query | grep -oP 'layout:\\s*\\K\\w+'",					0,		30},

	{"", "battery",					5,		0},
	
	{"", "volume",					0,		10},

	{" ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"", "date '+%b %d (%a) %-I:%M%p'",					1,		0},

};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " │ ";
static unsigned int delimLen = 5;
