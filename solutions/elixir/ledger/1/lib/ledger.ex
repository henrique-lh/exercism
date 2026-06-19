defmodule Ledger do
  @moduledoc """
  This solution was not designed by me. The idea here was to understand how a professional elixir programmer
  would write their code. Besides my knowledge in software engineering, I had to learn best practices for elixir code.

  The solution was designed by Pul, the elixir tutor in exercism.

  You'll see some comments in the code because besides the fact I copied line by line, I wanted to understand every single line
  of code
  """

  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries),
    do:
      with(
        sorted_entries <- sort(entries),
        data_lines <- Enum.map(sorted_entries, &data_line(currency, locale, &1)),
        report_lines <- [header_line(locale) | data_lines],
        do: Enum.join(report_lines, "\n") <> "\n"
      )

  defp sort(entries),
    do: Enum.sort_by(entries, &{&1.date.day, &1.description, &1.amount_in_cents})

  defp header_line(:en_US), do: format_line(["Date", "Description", "Change"])
  defp header_line(:nl_NL), do: format_line(["Datum", "Omschrijving", "Verandering"])

  defp data_line(currency, locale, entry),
    do:
      format_line([
        format_date(locale, entry.date),
        entry.description,
        format_cent_amount(locale, currency, entry.amount_in_cents) |> String.pad_leading(13, " ")
      ])

  defp format_line([date, description, change]),
    do: [cell(date, 10), cell(description, 25), cell(change, 13)] |> Enum.join(" | ")

  defp cell(content, width),
    do:
      if(String.length(content) <= width,
        do: String.pad_trailing(content, width),
        else: String.slice(content, 0, width - 3) <> "..."
      )

  defp format_date(:en_US, date),
    do: to_string(:io_lib.format("~2..0B/~2..0B/~4..0B", [date.month, date.day, date.year]))

  defp format_date(:nl_NL, date),
    do: to_string(:io_lib.format("~2..0B-~2..0B-~4..0B", [date.day, date.month, date.year]))

  defp format_cent_amount(locale, currency, in_cents),
    do:
      with(
        sign <- in_cents >= 0,
        cents <- rem(abs(in_cents), 100),
        fulls <- div(abs(in_cents), 100),
        ones <- rem(fulls, 1000),
        thousands <- div(fulls, 1000),
        formatted_number <- format_in_groups(locale, thousands, ones, cents),
        do: format_sign_and_currency(locale, currency, sign, formatted_number)
      )

  defp format_in_groups(:en_US, 0, ones, cents),
    do: to_string(:io_lib.format("~..0B.~2..0B", [ones, cents]))

  defp format_in_groups(:en_US, thousands, ones, cents),
    do: to_string(:io_lib.format("~.. B,~3..0B.~2..0B", [thousands, ones, cents]))

  defp format_in_groups(:nl_NL, 0, ones, cents),
    do: to_string(:io_lib.format("~..0B,~2..0B", [ones, cents]))

  defp format_in_groups(:nl_NL, thousands, ones, cents),
    do: to_string(:io_lib.format("~.. B.~3..0B,~2..0B", [thousands, ones, cents]))

  defp format_sign_and_currency(:en_US, :usd, true, number), do: "$#{number} "
  defp format_sign_and_currency(:en_US, :eur, true, number), do: "€#{number} "
  defp format_sign_and_currency(:en_US, :usd, false, number), do: "($#{number})"
  defp format_sign_and_currency(:en_US, :eur, false, number), do: "(€#{number})"
  defp format_sign_and_currency(:nl_NL, :usd, true, number), do: "$ #{number} "
  defp format_sign_and_currency(:nl_NL, :eur, true, number), do: "€ #{number} "
  defp format_sign_and_currency(:nl_NL, :usd, false, number), do: "$ -#{number} "
  defp format_sign_and_currency(:nl_NL, :eur, false, number), do: "€ -#{number} "
end

