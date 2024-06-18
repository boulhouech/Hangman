def user_option(option)
  @option = option
  until ['1', '2'].include?(@option)
    puts 'Invalid choice. Please choose 1 or 2.'
  end

  case @option
  when '1'
    start_new_game
  when '2'
    load_saved_game
  end
end
