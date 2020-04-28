#!/usr/bin/perl
use myfiles;
### Script open a files, perform some operations
# Exit codes
# 	1: Need to pass a correct number to choose process..
# 	2: Try to insert a data in details.txt file with ID not exist in data.txt..

my $id, $name, $email, $choose;

print "1. Insert a Data (Id, Name, Email) in data.txt file \n";
print "2. Insert a Details (Id, grade1, grade2, grade3) in details.txt file \n";
print "3. Delete a row in Data file \n";
print "4. Read Data by Id in files \n";
$choose = <>;
chomp $choose;


# 1. Insert a Data (Id, Name, Email) in data.txt file

if ($choose == 1) {

		while($id !~ /^-?\d+\.?\d*$/ || myfiles::checkIfIdExist($id)){
			print "Enter ID: ";
			$id = <>;
			chomp $id;
			if($id !~ /^-?\d+\.?\d*$/){print "Please enter correct Id, ";}
			if( myfiles::checkIfIdExist($id) == 1 ){ print "Please Enter another Id, ";}
		}


		print "Enter Name: ";
		$name = <>;
		chomp $name;

		while($email !~ /^[a-z0-9.]+\@[a-z0-9.-]+$/){
			print "Enter Email: ";
			$email = <>;
			chomp $email;
			if($email !~ /^[a-z0-9.]+\@[a-z0-9.-]+$/){print "Please enter correct Email, ";}

		}

		if($id && $name && $email){
			myfiles::insertData($id, $name, $email);
		}else{
			print "Can't Insert Data!";
		}


# 2. Insert a Details (Id, grade1, grade2, grade3) in details.txt file
}elsif ($choose == 2){

	while($id !~ /^-?\d+\.?\d*$/){
		print "Enter ID: ";
		$id = <>;
		chomp $id;
		if($id !~ /^-?\d+\.?\d*$/){print "Please enter correct Id, ";}
	}

	if( myfiles::checkIfIdExist($id) == 0 ){
		print "Please Enter main data of this Id first! \n";
		exit 2;
	}

	while($grd1 !~ /^-?\d+\.?\d*$/){
		print "Enter Grade1: ";
		$grd1 = <>;
		chomp $grd1;
		if($grd1 !~ /^-?\d+\.?\d*$/){print "Please enter correct grade, ";}
	}

	while($grd2 !~ /^-?\d+\.?\d*$/){
		print "Enter Grade2: ";
		$grd2 = <>;
		chomp $grd2;
		if($grd2 !~ /^-?\d+\.?\d*$/){print "Please enter correct grade, ";}
	}

	if($id && $grd1 && $grd2){
		myfiles::insertDetails($id, $grd1, $grd2);
	}else{
		print "Can't Insert Data!";
	}


# 3. Delete a row in Data file
}elsif ($choose == 3){

	while($id !~ /^-?\d+\.?\d*$/){
		print "Enter ID: ";
		$id = <>;
		chomp $id;
		if($id !~ /^-?\d+\.?\d*$/){print "Please enter correct Id, ";}
	}
	if($id){
		myfiles::deleteById($id);
	}else{
		print "Can't delete Data!";
	}


# 4. Read Data by Id in files
}elsif ($choose == 4){

	while($id !~ /^-?\d+\.?\d*$/){
		print "Enter ID: ";
		$id = <>;
		chomp $id;
		if($id !~ /^-?\d+\.?\d*$/){print "Please enter correct Id, ";}
	}
	if($id){
		myfiles::printFile($id);
	}else{
		print "Can't get Data!";
	}

# exit -> Ivalid Input
}else{
			print "Error: Invalid Input\n";
			exit 1;
}
