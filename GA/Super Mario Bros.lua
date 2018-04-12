--[[ Main Script File
 Info:    
 This is the main script that is set to run. This project uses a genetic algorithm
 to play the classic NES game Super Mario Bros. The program uses a ROM which is emuated in fceux emulator.
  
 Generations are made up of candidates which are individual runs of mario trying to get through a level until he dies,
 runs out of time or completes the level. Candidates are made up of a string of six binary inputs that represent button presses on a controller
 (up, down, left, right, A, B). Chromosomes are made of these strings of inputs and a weight to each input(determined by fitness). The fitness 
 value is a function of how far right on the x-axis of each level mario can get till completion. Crossover and mutation will be explained in 
 the genetic_algo.lua file.
--]]

require "table_utils"
require "other_utils"
require "candidate"
require "genetic_algo"

-- Constant values, memory locations & other useful things. 
-- Information that is stored in these variables are being pulled from specific RAM addresses of the game.
local PLAYER_XPAGE_ADDR     = 0x6D   --Player's page (screen) address
local PLAYER_PAGE_WIDTH     = 256    -- Width of pages
local PLAYER_XPOS_ADDR      = 0x86   --Player's position on the x-axis
local PLAYER_STATE_ADDR     = 0x000E --Player's state (dead/dying)
local PLAYER_VIEWPORT_ADDR  = 0x00B5 --Player's viewport status (falling)
local PLAYER_YPOS_ADDR      = 0x00CE --Player's y position address
local PLAYER_VPORT_HEIGHT   = 256    --raw height of viewport pages
local PLAYER_DOWN_HOLE      = 3    --VP+ypos val for falling into hole
local PLAYER_DYING_STATE    = 0x0B   --State value for dying player
local PLAYER_DEAD_STATE     = 0x06   --(CURRENTLY UNUSED!) State value for dead player
local PLAYER_FLOAT_STATE    = 0x001D --Used to check if player has won
local PLAYER_FLAGPOLE       = 0x03   --Player is sliding down flagpole.
local GAME_TIMER_ONES       = 0x07fA --Game Timer first digit
local GAME_TIMER_TENS       = 0x07f9 --Game Timer second digit
local GAME_TIMER_HUNDREDS   = 0x07f8 --Game Time third digit
local GAME_TIMER_MAX        = 400    --Max time allotted by game

-- Constant values which describe the state of the genetic algorithm
local MAX_CANDIDATES        = 200    --Number of candidates generated
local MAX_CONTROLS_PER_CAND = 1000   --Number of controls that each candidate has
local FRAME_MAX_PER_CONTROL = 20     --Number of frames that each control will last
local GA_SEL_TOPPERC        = .075   --top X percent used for selection/crossover.
local GA_MUTATION_RATE      = 0.008  --GA mutation rate
local GA_XVTIME_DELTA       = 75     --Delta for time v. distance

