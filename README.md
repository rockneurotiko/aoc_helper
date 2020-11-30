# AocHelper

Helper for your Advent of Code days.

## Install

`mix archive.install github rockneurotiko/aoc_helper`

From now on, you can use the mix task `mix aoc.new`.

## Usage

Create base code and try to download data:

`mix aoc.new --year 2020 --day 1`

Year and day are optional, if not provided it will use the current date. If you are doing the AoC day by day, just executing `mix aoc.new` will create it for the current day.

This command will create a module named `<YourPackage>.Aoc<year>.Day<day>.Solve` in the path `lib/<your_package>/<year>/<day>/solve.ex`

You have to implement `star1/1` and `star2/2`, and from the iex console you can call `<...>.Solve.solve()`, it will read the `input` file in the day directory and call `star1` and `star2`.

You can implement the `parse_line/1` to custom parsing the input lines.

You can see an example of the files generated [here](./lib/aoc_helper/2019/01)

## Data downloading

The mix task will try to use [`aocd`](https://github.com/wimglenn/advent-of-code-data) to download the data for the specified day.

I recommend installing and configuring the command in order to simplify your AoC daily flow even more.

The simplified installation and config is:

``` bash
pip install advent-of-code-data
```

Go to [https://adventofcode.com/](https://adventofcode.com/) and login, retrieve the cookie `session` value and save it in `~/.config/aocd/token`


## Example generated files:

- [solve.ex](./lib/aoc_helper/2019/01/solve.ex)
- [input](./lib/aoc_helper/2019/01/input)
