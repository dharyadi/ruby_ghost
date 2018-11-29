# GHOST
A multi-player version of the game ghost created entirely in Ruby with AI player option

## Overview
In Ghost, there is a dictionary of words, and players take turns adding one letter at at a time to a word fragment. If the fragment matches a full word in the dictionary, the previous player loses that round and earns a letter of the word "GHOST," such as "G" if it is the first round lost. A player loses the game when he/she spells the word "GHOST" entirely and is removed from gameplay. The winner is the last player left standing.

The game consists of multiple rounds, and each round consists of each player's turns. The goal of each round is to spell a word from the dictionary, with each player contributing a letter to the word fragment on each turn. The round ends when a word from the dictionary has been completely spelled out or if a player spells the word "GHOST" by making an invalid letter choice, leaving only one player in the game. The latter situation also results in the end of the game.

## GAMEPLAY
2-5 players may join the game. 

A player selects a letter. That letter is added to the word fragment. If the fragment is a substring of a word in the dictionary (starting from position 0), the fragment remains intact. Otherwise, the letter is removed from the fragment and the player earns a letter of the word "GHOST."

Gameplay continues until a word from the dictionary is spelled out. Once that happens, the previous player loses that round and earns a letter from the word "GHOST."

A player is removed from the game once the word "GHOST" is completed. Other players continue until only 1 remains, who is then crowned the winner. A single game may consist of multiple rounds, with the maximum number being number_of_players * 5 - 1.

## GAMEPLAY EXAMPLE (EXCLUDES GAME SETUP, JUST AN OVERVIEW)
Assume the dictionary only contains 2 words: "Cat", "Cow". The following is a 2-player game:
* Player 1, choose a letter: d
  * Sorry, that doesn't match any words. You're getting a "G."
  * Fragment: ""
* Player 2, choose a letter: c
  * Fantastic!
  * Fragment: "C"
* Player 1, choose a letter: a
  * Fantastic!
  * Fragment: "Ca"
* Player 2, choose a letter: m
  * Sorry, that doesn't match any words. You're getting a "G."
  * Fragment: "Ca"
* Player 1, choose a letter: t
  * Congratulations, you figured out the word Cat!
  * Player 2, you lose this round. You're getting a "H".
* Scores: Player 1 "G", Player 2 "GH"
* ...(Additional rounds are played until...)
* Player 2, choose a letter: w
  * Sorry, that doesn't match any words. You're getting a "T."
  * Looks like you've been spooked by the GHOST! Player 2, you lose!
  * Player 1 is the winner!

## AI Player
Playing against the AI player is optional. This player, whenever possible, chooses the letter that will most likely prevent it from losing a round by comparing possible word fragments against the dictionary. The AI always selects the letter that provides the most opportunities for NOT losing, i.e. not being the player who chooses the second to last letter of a dictionary word. The AI player never chooses an invalid letter.
