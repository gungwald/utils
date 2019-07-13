program SplitEnv;
uses
	SysUtils;
	
const
	MAX_SIZE = 1024;
	END_OF_STRING = CHR(0);
type
	String1024 = array [1..MAX_SIZE] of Char; (* Terminated by chr 0 in FreePascal *)
	StringArray = array [1..MAX_SIZE] of String1024; (* Terminated by an empty string *)
var
	path : String1024;
	i : Integer;
	
function split(toSplit:String1024; splittor:Char; var parts:StringArray) : Integer;
	(* Find character "c" in string "s" and return the index of "c". *)
	function find(s:String1024; c:Char; startIndex:Integer) : Integer;
	var
		i:Integer;
		found:Boolean;
		foundAtIndex:Integer;
	begin
		i := startIndex;
		found := false;
		foundAtIndex := -1;
		while (s[i] <> END_OF_STRING) and (not found) do begin
			if s[i] = c then begin
				found := true;
				foundAtIndex = i;
			end
		end;
		find := foundAtIndex;
	end; (* find *)
var
	partCount:Integer;
	i:Integer;
begin
	i := 0;
	partCount := 0;
	split := 0;
	i := find(toSplit, splittor, 1);
	while i > 0 do
	begin
	end;
end; (* split *)

(* Main program below *)
begin
	path := GetEnvironmentVariable('PATH');
	writeln(path);
	for i := 1 to MAX_SIZE do
	begin
		writeln(path[i], ' = ', ord(path[i]));
	end;
end.
