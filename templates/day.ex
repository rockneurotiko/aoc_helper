defmodule <%= app_module %>.Aoc<%= year %>.Day<%= day %>.Solve do
  @base_path "<%= base_path %>"

  def star1(input) do
    "TODO"
  end

  def star2(input) do
    "TODO"
  end

  defp parse_line(line) do
    line
  end

  # Helpers

  def solve(fname \\ "input") do
    do_solve(fname)
  end

  def solve_test(), do: solve("input_test")

  defp do_solve(fname) do
    path = Path.join(@base_path, fname)

    input = path |> File.read!() |> parse!()
    star1 = star1(input)
    IO.puts("Star 1: #{star1}")

    star2 = star2(input)
    IO.puts("Star 2: #{star2}")
  end

  defp parse!(t) do
    t
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end
end
