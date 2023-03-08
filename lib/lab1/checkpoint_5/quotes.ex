defmodule Quotes do

  def get_response do
    HTTPoison.get!("https://quotes.toscrape.com/")
  end

  def get_quotes do
    response = get_response()
    response.body
    |> Floki.find("div.quote")
    |> Enum.map(fn div ->
      %{
        quote: get_quote(div),
        author: get_author(div),
        tags: get_tags(div)
      }
    end)
  end

  def get_quote(div) do
    div
    |> Floki.find("span.text")
    |> Floki.text()
  end

  def get_author(div) do
    div
    |> Floki.find("small.author")
    |> Floki.text()
  end

  def get_tags(div) do
    div
    |> Floki.find("div.tags a.tag")
    |> Enum.map(fn tag ->
      Floki.text(tag)
    end)
  end

  def write_to_file() do
    File.write!("quotes.json", Jason.encode!(get_quotes()))
  end

end


# iex -S mix
# Quotes.get_response
# Quotes.get_quotes
# Quotes.write_to_file()
