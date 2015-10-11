class QuizController < ApplicationController
  POKEMON_SELECTIONS = [:haunter, :chikorita, :lapras, :charmander, :wartortle, :bulbasaur, :zubat, :onyx, :abra]
  def index
  end

  def determine_avatar
    h = Hash.new
    POKEMON_SELECTIONS.each do |pokemon|
      h[pokemon] = 0
    end

    # Question 1: Breakfast, lunch, or dinner?
      dinner_increments = [1, 0, 1, 0, 1, 0, 1, 1, 0]
      lunch_increments = [0, 1, 0, 0, 0, 0, 0, 0, 0]
      breakfast_increments = [0, 0, 0, 1, 0, 1, 0, 0, 1]
    case params.fetch(:q1).to_sym
    when :dinner
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += dinner_increments.shift
      end
    when :lunch
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += lunch_increments.shift
      end
    when :breakfast
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += breakfast_increments.shift
      end
    end

    # Question 2: Favorite season?
      fall_increments = [0, 1, 1, 0, 0, 0, 0, 0, 1]
      winter_increments = [1, 0, 0, 0, 1, 0, 1, 1, 0]
      spring_increments = [0, 0, 0, 0, 0, 0, 0, 0, 0]
      summer_increments = [0, 0, 0, 1, 0, 1, 0, 0, 0]
    case params.fetch(:q2).to_sym
    when :fall
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += fall_increments.shift
      end
    when :winter
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += winter_increments.shift
      end
    when :spring
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += spring_increments.shift
      end
    when :summer
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += summer_increments.shift
      end
    end

    # Question 3: Day or night?
      day_increments = [0, 1, 1, 1, 0, 0, 1, 1, 0]
      night_increments = [1, 0, 0, 0, 1, 1, 0, 0, 1]
    case params.fetch(:q2).to_sym
    when :day
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += day_increments.shift
      end
    when :night
      POKEMON_SELECTIONS.each do |pokemon|
        h[pokemon] += night_increments.shift
      end
    end

    current_user.update(avatar: h.key(h.values.max))

    redirect_to root_path
  end

end
