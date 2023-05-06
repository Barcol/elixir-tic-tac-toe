defmodule TicTacToe do
  @board_size 3

  def hello do
    board = init_board()
    player = :x
    loop(board, player)
  end

  defp loop(board, player) do
    IO.puts("Current board:")
    print_board(board)

    case check_winner(board) do
      :x ->
        IO.puts("X wins!")

      :o ->
        IO.puts("O wins!")

      :draw ->
        IO.puts("It's a draw!")

      :in_progress ->
        move = get_move(player)
        new_board = update_board(board, move, player)
        new_player = toggle_player(player)
        loop(new_board, new_player)
    end
  end

  defp get_move(player) do
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

  defp update_board(board, {row, col}, player) do
    if get_cell(board, row, col) == :empty do
      set_cell(board, row, col, player)
    else
      IO.puts("That cell is already occupied. Try again")
      move = get_move(player)
      update_board(board, move, player)
    end
  end

  defp get_cell(board, row, col) do
    List.flatten(board) |> Enum.at(row * @board_size + col)
  end

  defp set_cell(board, row, col, player) do
    List.update_at(board, row, fn r ->
      List.update_at(r, col, fn _ ->
        player
      end)
    end)
  end

  defp toggle_player(:x), do: :o
  defp toggle_player(:o), do: :x

  defp init_board do
    for _ <- 1..@board_size, do: for(_ <- 1..@board_size, do: :empty)
  end

  defp print_board(board) do
    board
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn cell ->
        case cell do
          :empty -> "-"
          :x -> "X"
          :o -> "O"
        end
      end)
      |> Enum.join(" ")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  defp check_winner(board) do
    winning_lines = [
      # rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      # columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      # diagonals
      [0, 4, 8],
      [2, 4, 6]
    ]

    for line <- winning_lines do
      [c1, c2, c3] =
        Enum.map(line, fn i -> get_cell(board, rem(i, @board_size), div(i, @board_size)) end)
      
    if c1 == c2 and c2 == c3 and c3 != :empty do
        c1
      end
    end
    |> Enum.reject(&is_nil/1)
    |> List.first() ||
      if Enum.member?(List.flatten(board), :empty) do
        :in_progress
      else
        :draw
      end
  end
end
