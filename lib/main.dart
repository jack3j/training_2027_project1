import 'dart:ffi';
import 'dart:io';

class Team {
  int teamNumber;
  String teamName;
  List<Match> matches;

  Team({
    required this.teamNumber,
    required this.teamName,
    required this.matches,
  });
}

class Match {
  int matchNumber;
  int score;

  Match({required this.matchNumber, required this.score});
}

// Global list of teams
List<Team> teams = [
  Team(teamNumber: 2046, teamName: 'Bear Metal', matches: [Match(matchNumber: 2, score: 4), Match(matchNumber: 3, score: 9)]),
  Team(teamNumber: 2910, teamName: 'Jack in the Bot', matches: []),
  Team(teamNumber: 254, teamName: 'The Cheesy Poofs', matches: []),
  Team(teamNumber: 1678, teamName: 'Citrus Circuits', matches: []),
  Team(teamNumber: 118, teamName: 'Robonauts', matches: []),
  Team(teamNumber: 148, teamName: 'Robowranglers', matches: []),
  Team(teamNumber: 2056, teamName: 'OP Robotics', matches: []),
  Team(teamNumber: 1323, teamName: 'MadTown Robotics', matches: []),
  Team(teamNumber: 4414, teamName: 'Hightide', matches: []),
  Team(teamNumber: 971, teamName: 'Spartan Robotics', matches: []),
  Team(teamNumber: 973, teamName: 'Greybots', matches: []),
  Team(teamNumber: 1690, teamName: 'Orbit', matches: []),
  Team(teamNumber: 2471, teamName: 'Mean Machine', matches: []),
  Team(teamNumber: 5940, teamName: 'BREAD', matches: []),
];

void runCli(List<String> arguments) {
  print('--- Welcome to Bear Metal Burgers ---');
  print('');

  // while(true) creates an infinite loop
  while (true) {
    print('Choose an option: ');
    print('1 -- Register a team');
    print('2 -- View & Edit teams');
    print('');
    stdout.write('Select option: ');

    try {
      String input = stdin.readLineSync() ?? '';
      int parsedInput = int.parse(input); // Convert string to int

      switch (parsedInput) {
        case 1:
          registerTeam();
        case 2:
          viewTeams();
        default:
          print('$parsedInput is not an option!');
      }
    } catch (e) {
      print('Enter a number!');
      continue;
    }
  }
}

void registerTeam() {
  print('REGISTERING A TEAM');
  print('');

  int teamNum = askForInt('Enter a team number: ');
  String teamName = askForString('Enter a team name: ');

  teams.add(Team(teamNumber: teamNum, teamName: teamName, matches: []));

  print('Added $teamName to registered teams');
}

void viewTeams() {
  print('VIEWING TEAMS');
  print('');

  int amountOfTeams = teams.length;
  int currentPage = 0;
  int amountOfPages = (amountOfTeams / 10).ceil();

  if (amountOfTeams == 0) {
    print('No teams registered.');
    return;
  }

  while (true) {
    int startIndex = currentPage * 10;
    int endIndex = (startIndex + 10).clamp(0, teams.length);
    int teamsOnPage = endIndex - startIndex;

    print('');
    print('Page ${currentPage + 1} / $amountOfPages');

    for (int i = startIndex; i < endIndex; i++) {
      Team currentTeam = teams[i];

      print(
        '${i - startIndex} -- Team ${currentTeam.teamNumber}, ${currentTeam.teamName}',
      );
    }

    print('');
    String userInput = askForString(
      'Select 0${teamsOnPage > 1 ? '-${teamsOnPage - 1} to view a team' : ' to view ${teams[startIndex].teamName}'}, n for next page, p for previous page, and e to exit: ',
    );

    switch (userInput) {
      case 'n':
        if (currentPage < amountOfPages - 1) {
          currentPage++;
        }

      case 'p':
        if (currentPage > 0) {
          currentPage--;
        }

      case 'e':
        return;

      default:
        {
          int? number = int.tryParse(userInput);
          if (number == null || number >= teamsOnPage) {
            print('\'$userInput\' is not an option');
            continue;
          }

          viewTeamDetails(startIndex + number);
        }
    }
  }
}

void viewTeamDetails(int teamsListIndex) {
  Team team = teams[teamsListIndex];
  
  print('VIEWING TEAM DETAILS');
  print('Team ${team.teamNumber}, ${team.teamName}');
  print('');
  
  if(team.matches.isEmpty) {
    print('${team.teamNumber} hasn\'t played in any matches');
    return;
  }
  
  for (Match match in team.matches) {
    print('MATCH ${match.matchNumber}');
    print('Scored ${match.score} points');
    print('');
  }
}

String askForString(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

int askForInt(String prompt) {
  while (true) {
    try {
      String rawInput = askForString(prompt);
      return int.parse(rawInput);
    } catch (e) {
      print('That\'s not a number!');
    }
  }
}
