defmodule Board do
import Player

  @board_size 3

  def init_board do
    for _ <- 1..@board_size, do: for(_ <- 1..@board_size, do: :empty)
  end

def update_board(board, {row, col}, player) do
    if get_cell(board, row, col) == :empty do
      set_cell(board, row, col, player)
    else
      IO.puts("That cell is already occupied. Try again")
      move = get_move(player)
      update_board(board, move, player)
    end
  end

  def get_cell(board, row, col) do
    List.flatten(board) |> Enum.at(row * @board_size + col)
  end

  def set_cell(board, row, col, player) do
    List.update_at(board, row, fn r ->
      List.update_at(r, col, fn _ ->
        player
      end)
    end)
  end

 def print_board(board) do
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

  def check_winner(board) do
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