defmodule Reader1 do
  use GenServer

  def start_link(url) do
    GenServer.start_link(__MODULE__, url: url)
  end

  def init([url: url]) do
    IO.puts("\n--------- Read SSE Streams ---------")
    HTTPoison.get!(url, [], [recv_timeout: :infinity, stream_to: self()])
    {:ok, nil}
  end

  def handle_info(%HTTPoison.AsyncChunk{chunk: chunk}, _state) do
    process_event(chunk)
    {:noreply, nil}
  end

  def handle_info(%HTTPoison.AsyncStatus{}, _state) do
    {:noreply, nil}
  end

  def handle_info(%HTTPoison.AsyncHeaders{}, _state) do
    {:noreply, nil}
  end

  def handle_info(%HTTPoison.AsyncEnd{}, _state) do
    {:noreply, nil}
  end

  defp process_event("event: \"message\"\n\ndata: " <> message) do
    {success, data} = Jason.decode(String.trim(message))
    bad_words = [
      "arse",
      "arsehole",
      "ass",
      "asshole",
      "balls",
      "bastard",
      "beaver",
      "beef curtains",
      "bellend",
      "bint",
      "bitch",
      "bloodclaat",
      "bloody",
      "bollocks",
      "bugger",
      "bullshit",
      "child-fucker",
      "christ on a bike",
      "christ on a cracker",
      "clunge",
      "cock",
      "cow",
      "crap",
      "cunt",
      "damn",
      "dick",
      "dickhead",
      "effing",
      "fuck",
      "FUCK",
      "fanny",
      "feck",
      "flaps",
      "frigger",
      "fuck",
      "gash",
      "ginger",
      "git",
      "goddam",
      "goddamn",
      "godsdamn",
      "hell",
      "holy shit",
      "horseshit",
      "jesus christ",
      "jesus fuck",
      "jesus h. christ",
      "jesus harold christ",
      "jesus wept",
      "jesus, mary and joseph",
      "judas priest",
      "knob",
      "minge",
      "minger",
      "motherfucker",
      "munter",
      "nigga",
      "pissed",
      "pissed off",
      "prick",
      "punani",
      "pussy",
      "shit",
      "shit ass",
      "shitass",
      "slut",
      "snatch",
      "sod",
      "sod-off",
      "son of a bitch",
      "son of a whore",
      "sweet jesus",
      "tit",
      "tits",
      "twat",
      "wanker"
    ]
    if success == :ok do
      tweet = data["message"]["tweet"]
      text = tweet["text"]

      # IO.inspect(data["message"]["tweet"]["text"])
      # IO.inspect("END OF FLAGG")
      # if Enum.member?(bad_words, data["message"]["tweet"]["text"]) do
      #   IO.inspect(text <> "BAD FLAG")
      #   text = replace_bad_words(data["message"]["tweet"]["text"], bad_words)
      #   IO.inspect(text <> "BAD FLAG")

      # end
      censored_text =
        for word <- String.split(text, " ") do
          if Enum.member?(bad_words, word) do
            String.duplicate("*", String.length(word))
          else
            word
          end
        end
        |> Enum.join(" ")
      # IO.inspect(censored_text)

      hashtags = tweet["entities"]["hashtags"]
      # speculative
      printer_id_not_ocupied = Balancer1.who_not_occupied()
      Supervisorprinter1.print(censored_text, printer_id_not_ocupied)
      printer_any_id = Balancer1.any_printer()
      Supervisorprinter1.print(censored_text, printer_any_id)
      Enum.each(hashtags, fn hashtag ->
        Mostpopular1.most_popular(hashtag["text"]) end)
    end
  end

  def replace_bad_words(str, bad_words) do
    Enum.reduce(bad_words, str, fn word, acc ->
      String.replace(acc, word, String.duplicate("*", String.length(word)))
    end)
  end
end



# docker run -p 4000:4000 alexburlacu/rtp-server:faf18x
# Supervisorprinter1.start_link()
# Supervisorreader1.start_link()

# Lab1.execute()
