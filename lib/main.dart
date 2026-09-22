import 'dart:io';

void runCli(List<String> arguments) {
  List<int> teamNumbers = [];
  
  // while(true) creates an infinite loop
  while(true) {
    stdout.write('Enter team number: ');
    
    String input = stdin.readLineSync() ?? '';
    int? parsedInput = int.tryParse(input); // Convert string to int
   
    if (parsedInput == null) {
      print('Bad input');
      continue; // continue stops the current iteration and goes back to the beginning
    }
    
    teamNumbers.add(parsedInput);
    
    print('Collected teams:');
    for (var team in teamNumbers) {
      print(team);
    }
  }
}
