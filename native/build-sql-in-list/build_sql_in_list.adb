with Ada.Command_Line;
with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;

use Ada.Command_Line;
use Ada.Exceptions;
use Ada.Strings.Unbounded;
use Ada.Strings.Unbounded.Text_IO;

procedure Build_SQL_In_List is
   package T_IO renames Ada.Text_IO;
   In_List : Unbounded_String := To_Unbounded_String("");
   Element : Unbounded_String;
begin
   while not T_IO.End_Of_File loop
      Element := Get_Line;
      In_List := In_List & "'" & Element & "', ";
   end loop;
   Put(In_List);
exception
   when e:others =>
      T_IO.Put(Exception_Information(e));
end Build_SQL_In_List;
