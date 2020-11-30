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
    target = "#{base_path}/solve.ex"
    template_path = Path.expand("../../../../templates/day.ex", __DIR__)

    contents =
      EEx.eval_file(template_path,
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
end
