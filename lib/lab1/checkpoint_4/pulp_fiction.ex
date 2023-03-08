defmodule PulpFiction do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      %{
        id: :killer,
        start: {Killer, :start_link, []}
      },
      %{
        id: :pussy,
        start: {Pussy, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def exchange() do
    Killer.ask()
    exchange()
  end

  def count() do
    Supervisor.count_children(__MODULE__)
  end
end

defmodule Killer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def ask() do
    GenServer.call(__MODULE__, :ask)
  end

  def init(_) do
    state = %{
      questions: [
        "What does Marcellus look like?",
        "What country you from?!",
        "What ain't no country I've ever heard of! They speak English in What?",
        "English motherfucker do you speak it!?",
        "Describe what Marcellus Wallace looks like.",
        "Say <what> again. SAY WHAT again! And I dare you, I double dare you motherfucker! Say what one more time.",
        "Dose he look like a bitch?",
      ],
      what_count: 0,
    }
    {:ok, state}
  end

  def handle_call(:ask, _from, state) do
    Process.sleep(1500)
    question = List.first(state[:questions])
    IO.inspect("Killer: #{question}")
    state = %{state | questions: List.delete_at(state[:questions], 0)}

    answer = Pussy.answer()

    if (answer == "What?") do
      state = %{state | what_count: state[:what_count] + 1}

      case state[:what_count] do
        5 ->
          Process.sleep(500)
          IO.inspect("BANG!")
          Pussy.kill()
        _ -> :ok
      end

      {:reply, question, state}
    else
      {:reply, question, state}
    end
  end
end

defmodule Pussy do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def answer() do
    GenServer.call(__MODULE__, :answer)
  end

  def kill() do
    GenServer.cast(__MODULE__, :kill)
  end

  def init(_) do
    state = %{
      answers: [
        "What?",
        "What?",
        "What?",
        "Yes",
        "What?",
        "He's black..He's bald",
        "What?",
      ]
    }
    {:ok, state}
  end

  def handle_call(:answer, _from, state) do
    Process.sleep(2000)

    answer = List.first(state[:answers])
    IO.inspect("Guy: #{answer}")
    state = %{state | answers: List.delete_at(state[:answers], 0)}
    {:reply, answer, state}
  end

  def handle_cast(:kill, state) do
    {:stop, :normal, state}
  end
end

# from check 4

# c("pulp_fiction.ex")
# PulpFiction.start_link()
# PulpFiction.exchange()
