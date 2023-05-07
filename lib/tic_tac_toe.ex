defmodule TicTacToe do
  import Board
  import Player

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

  defp toggle_player(:x), do: :o
  defp toggle_player(:o), do: :x
end
