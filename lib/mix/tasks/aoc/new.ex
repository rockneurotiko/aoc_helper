defmodule Mix.Tasks.Aoc.New do
  use Mix.Task

  import Mix.Generator

  @args [year: :integer, day: :integer]

  def run(args) do
    case OptionParser.parse(args, strict: @args) do
      {_, _, [_ | _] = errors} ->
        IO.puts("Invalid arguments: #{inspect(errors)}")

      {args, _, _} ->
        today = Date.utc_today()
        year = args[:year] || today.year
        day = args[:day] || today.day

        do_create_file(year, day)
    end
  end

  defp do_create_file(year, day) do
    app = Mix.Project.config()[:app]
    app_string = app |> Atom.to_string()

    day = day |> to_string() |> String.pad_leading(2, "0")

    app_module =
      app_string |> String.split("_") |> Enum.map(&String.capitalize/1) |> Enum.join("")

    base_path = "lib/#{app}/#{year}/#{day}"
    target = Path.join(base_path, "solve.ex")

    contents =
      day_template(
        app_module: app_module,
        base_path: base_path,
        year: year,
        day: day
      )

    create_file(target, contents)

    download_data(year, day, base_path)

    IO.puts("Done!")
  end

  defp download_data(year, day, base_path) do
    case System.cmd("which", ["aocd"]) do
      {_, 0} ->
        do_download_data(year, day, base_path)

      _ ->
        IO.puts("aocd not installed, skip download data")
    end
  end

  defp do_download_data(year, day, base_path) do
    case System.cmd("aocd", ["#{day}", "#{year}"]) do
      {input, 0} ->
        write_input(input, base_path)

      _ ->
        IO.puts("Error downloading AoC data for #{year}/#{day}")
    end
  end

  defp write_input(input, base_path) do
    file = Path.join(base_path, "input")

    create_file(file, input)
  end

  embed_template(:day, """
  defmodule <%= @app_module %>.Aoc<%= @year %>.Day<%= @day %>.Solve do
    @base_path Path.dirname(__ENV__.file)

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

    def solve(fname \\\\ "input") do
      do_solve(fname)
    end

    def solve_test(), do: solve("input_test")

    defp do_solve(fname) do
      path = Path.join(@base_path, fname)

      input = path |> File.read!() |> parse!()
      star1 = star1(input)
      IO.puts("Star 1: " <> to_string(star1))

      star2 = star2(input)
      IO.puts("Star 2: " <> to_string(star2))
    end

    defp parse!(t) do
      t
      |> String.split("\\n")
      |> Enum.filter(& &1 != "")
      |> Enum.map(&parse_line/1)
    end
  end
  """)
end
