#!/usr/bin/env wish8.6
#
# Genesys Dice Roller!
#

namespace import ::tcl::mathfunc::*

wm title . "Genesys Dice Roller"
wm minsize . 400 300

# Page 10 -- these are all "in order"
set BOOST_SYMBOLS [list                                                   \
  [list _ _] [list _ _] [list SUCCESS _]                                  \
  [list SUCCESS ADVANTAGE] [list ADVANTAGE ADVANTAGE] [list ADVANTAGE _]  \
]

set SETBACK_SYMBOLS [list                          \
  [list _ _] [list _ _] [list FAILURE _]           \
  [list FAILURE _] [list THREAT _] [list THREAT _] \
]

set ABILITY_SYMBOLS [list                                                                   \
  [list _ _] [list SUCCESS _] [list SUCCESS _] [list SUCCESS SUCCESS]                       \
  [list ADVANTAGE _] [list ADVANTAGE _] [list SUCCESS ADVANTAGE] [list ADVANTAGE ADVANTAGE] \
]

set DIFFICULTY_SYMBOLS [list                                                  \
  [list _ _] [list FAILURE _] [list FAILURE FAILURE] [list THREAT _]          \
  [list THREAT _] [list THREAT _] [list THREAT THREAT] [list FAILURE THREAT]  \
]

set PROFICIENCY_SYMBOLS [list                                                                     \
  [list _ _] [list SUCCESS _] [list SUCCESS _] [list SUCCESS SUCCESS]                             \
  [list SUCCESS SUCCESS] [list ADVANTAGE _] [list SUCCESS ADVANTAGE] [list SUCCESS ADVANTAGE]     \
  [list SUCCESS ADVANTAGE] [list ADVANTAGE ADVANTAGE] [list ADVANTAGE ADVANTAGE] [list TRIUMPH _] \
]

set CHALLENGE_SYMBOLS [list                                                         \
  [list _ _] [list FAILURE _] [list FAILURE _] [list FAILURE FAILURE]               \
  [list FAILURE FAILURE] [list THREAT _] [list THREAT _] [list FAILURE THREAT]      \
  [list FAILURE THREAT] [list THREAT THREAT] [list THREAT THREAT] [list DESPAIR _]  \
]

# These represent the number of dice which will be rolled.
set n_boost 0
set n_ability 0
set n_proficiency 0
set n_setback 0
set n_difficulty 0
set n_challenge 0

# This represents the final tally of dice after a roll.
set final_blank 0
set final_success 0
set final_advantage 0
set final_triumph 0
set final_failure 0
set final_threat 0
set final_despair 0

# Some symbols
image create photo ::img::ADVANTAGE -file data/advantage.png
image create photo ::img::DESPAIR -file data/despair.png
image create photo ::img::FAILURE -file data/failure.png
image create photo ::img::SUCCESS -file data/success.png
image create photo ::img::THREAT -file data/threat.png
image create photo ::img::TRIUMPH -file data/triumph.png

########## ########## ##########

proc add_boost_die {} {
  global n_boost
  incr n_boost
  report
}

proc add_ability_die {} {
  global n_ability
  incr n_ability
  report
}

proc add_proficiency_die {} {
  global n_proficiency
  incr n_proficiency
  report
}

proc add_setback_die {} {
  global n_setback
  incr n_setback
  report
}

proc add_difficulty_die {} {
  global n_difficulty
  incr n_difficulty
  report
}

proc add_challenge_die {} {
  global n_challenge
  incr n_challenge
  report
}

proc clear {} {
  global n_boost n_ability n_proficiency n_setback n_difficulty n_challenge
  global final_blank final_success final_advantage final_triumph final_failure final_threat final_despair

  set n_boost 0
  set n_ability 0
  set n_proficiency 0
  set n_setback 0
  set n_difficulty 0
  set n_challenge 0

  set final_blank 0
  set final_success 0
  set final_advantage 0
  set final_triumph 0
  set final_failure 0
  set final_threat 0
  set final_despair 0

  report
}

proc report {} {
  global n_boost n_ability n_proficiency n_setback n_difficulty n_challenge
  puts "=============================="
  puts "n_boost = ${n_boost}"
  puts "n_ability = ${n_ability}"
  puts "n_proficiency = ${n_proficiency}"
  puts "n_setback = ${n_setback}"
  puts "n_difficulty = ${n_difficulty}"
  puts "n_challenge = ${n_challenge}"
  puts "=============================="
  puts ""
}

# Returns a number in the range [0, x).
proc randint {x} {
  return [entier [expr {[rand] * $x}]]
}

# They're just lists plain numbers at this stage -- we need to convert them to the
# symbols, and then do the arithmetic on the symbols.
proc reduce_dice {boost ability proficiency setback difficulty challenge} {
  global                \
    BOOST_SYMBOLS       \
    ABILITY_SYMBOLS     \
    PROFICIENCY_SYMBOLS \
    SETBACK_SYMBOLS     \
    DIFFICULTY_SYMBOLS  \
    CHALLENGE_SYMBOLS

  global            \
    final_blank     \
    final_success   \
    final_advantage \
    final_triumph   \
    final_failure   \
    final_threat    \
    final_despair

  dict set final _ 0
  dict set final SUCCESS 0
  dict set final ADVANTAGE 0
  dict set final TRIUMPH 0
  dict set final FAILURE 0
  dict set final THREAT 0
  dict set final DESPAIR 0

  foreach result $boost {
    set entry [lindex $BOOST_SYMBOLS $result]
    puts ">>> (Boost) [lindex $entry 0] [lindex $entry 1]"
    foreach symbol $entry { dict incr final $symbol }
  }

  foreach result $ability {
    set entry [lindex $ABILITY_SYMBOLS $result]
    puts ">>> (Ability) [lindex $entry 0] [lindex $entry 1]"
    foreach symbol $entry { dict incr final $symbol }
  }

  foreach result $proficiency {
    set entry [lindex $PROFICIENCY_SYMBOLS $result]
    puts ">>> (Proficiency) [lindex $entry 0] [lindex $entry 1]"
    foreach symbol $entry { dict incr final $symbol }
  }

  foreach result $setback {
    set entry [lindex $SETBACK_SYMBOLS $result]
    puts ">>> (Setback) [lindex $entry 0] [lindex $entry 1]"
    foreach symbol $entry { dict incr final $symbol }
  }

  foreach result $difficulty {
    set entry [lindex $DIFFICULTY_SYMBOLS $result]
    puts ">>> (Difficulty) [lindex $entry 0] [lindex $entry 1]"
    foreach symbol $entry { dict incr final $symbol }
  }

  foreach result $challenge {
    set entry [lindex $CHALLENGE_SYMBOLS $result]
    puts ">>> (Challenge) [lindex $entry 0] [lindex $entry 1]"
    foreach symbol $entry { dict incr final $symbol }
  }

  puts "========= ROLL RESULTS ========="
  set final_blank [dict get $final _]
  set final_success [dict get $final SUCCESS]
  set final_advantage [dict get $final ADVANTAGE]
  set final_triumph [dict get $final TRIUMPH]
  set final_failure [dict get $final FAILURE]
  set final_threat [dict get $final THREAT]
  set final_despair [dict get $final DESPAIR]

  puts "(blank) ${final_blank}"
  puts "Success ${final_success}"
  puts "Advantage ${final_advantage}"
  puts "Triumph ${final_triumph}"
  puts "Failure ${final_failure}"
  puts "Threat ${final_threat}"
  puts "Despair ${final_despair}"
  puts ""

  puts ">>>>>>> ACTUAL FINAL TALLY <<<<<<<"
  set ultimate_success [expr {($final_success + $final_triumph) - ($final_failure + $final_despair)}]
  set ultimate_advantage [expr {$final_advantage - $final_threat}]
  puts "${ultimate_success} Success"
  puts "${ultimate_advantage} Advantage"
  puts ""
  puts ""
}

proc roll {} {
  global n_boost n_ability n_proficiency n_setback n_difficulty n_challenge

  set boost [list] 
  set ability [list]
  set proficiency [list]
  set setback [list]
  set difficulty [list]
  set challenge [list]

  for {set i 0} {$i < $n_boost} {incr i} {
    lappend boost [randint 6]
  }

  for {set i 0} {$i < $n_ability} {incr i} {
    lappend ability [randint 8]
  }

  for {set i 0} {$i < $n_proficiency} {incr i} {
    lappend proficiency [randint 12]
  }

  for {set i 0} {$i < $n_setback} {incr i} {
    lappend setback [randint 6]
  }

  for {set i 0} {$i < $n_difficulty} {incr i} {
    lappend difficulty [randint 8]
  }

  for {set i 0} {$i < $n_challenge} {incr i} {
    lappend challenge [randint 12]
  }

  puts "BOOST => [join $boost]"
  puts "ABILITY => [join $ability]"
  puts "PROFICIENCY => [join $proficiency]"
  puts "SETBACK => [join $setback]"
  puts "DIFFICULTY => [join $difficulty]"
  puts "CHALLENGE => [join $challenge]"

  set results [reduce_dice $boost $ability $proficiency $setback $difficulty $challenge]
}

########## ########## ##########

button .btnClear -text "(clear)" -command clear
button .btnRoll -text "Roll!" -command roll
button .btnAddBoostDie -text "+ Boost" -command add_boost_die
button .btnAddAbilityDie -text "+ Ability" -command add_ability_die
button .btnAddProficiencyDie -text "+ Proficiency" -command add_proficiency_die
button .btnAddSetbackDie -text "+ Setback" -command add_setback_die
button .btnAddDifficultyDie -text "+ Difficulty" -command add_difficulty_die
button .btnAddChallengeDie -text "+ Challenge" -command add_challenge_die

label .labelBlankName -text "(blank)"
label .labelSuccessName -image ::img::SUCCESS
label .labelAdvantageName -image ::img::ADVANTAGE
label .labelTriumphName -image ::img::TRIUMPH
label .labelFailureName -image ::img::FAILURE
label .labelThreatName -image ::img::THREAT
label .labelDespairName -image ::img::DESPAIR

label .labelFinalBlank -textvariable final_blank
label .labelFinalSuccess -textvariable final_success
label .labelFinalAdvantage -textvariable final_advantage
label .labelFinalTriumph -textvariable final_triumph
label .labelFinalFailure -textvariable final_failure
label .labelFinalThreat -textvariable final_threat
label .labelFinalDespair -textvariable final_despair

grid .btnClear -row 0 -column 0
grid .btnAddBoostDie -row 1 -column 0
grid .btnAddAbilityDie -row 2 -column 0
grid .btnAddProficiencyDie -row 3 -column 0
grid .btnAddSetbackDie  -row 4 -column 0
grid .btnAddDifficultyDie -row 5 -column 0
grid .btnAddChallengeDie  -row 6 -column 0
grid .btnRoll -row 7 -column 0

grid .labelBlankName -row 0 -column 1
grid .labelFinalBlank -row 0 -column 2

grid .labelSuccessName -row 1 -column 1
grid .labelFinalSuccess -row 1 -column 2
grid .labelAdvantageName -row 1 -column 3
grid .labelFinalAdvantage -row 1 -column 4
grid .labelTriumphName -row 1 -column 5
grid .labelFinalTriumph  -row 1 -column 6

grid .labelFailureName -row 2 -column 1
grid .labelFinalFailure -row 2 -column 2
grid .labelThreatName -row 2 -column 3
grid .labelFinalThreat -row 2 -column 4
grid .labelDespairName -row 2 -column 5
grid .labelFinalDespair -row 2 -column 6
