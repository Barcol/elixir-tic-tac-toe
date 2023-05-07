defmodule Player do
  def get_move(player) do
    IO.puts("#{player}'s turn. Enter your move (1-9)")
    input = IO.gets("")

    case String.trim(input) do
      "1" ->
        {0, 0}

      "2" ->
        {0, 1}

      "3" ->
        {0, 2}

      "4" ->
        {1, 0}

      "5" ->
        {1, 1}

      "6" ->
        {1, 2}

      "7" ->
        {2, 0}

      "8" ->
        {2, 1}

      "9" ->
        {2, 2}

      _ ->
        IO.puts("Invalid move, try again.")
        get_move(player)
    end
  end
end