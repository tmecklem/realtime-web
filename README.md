# Designing Real-time Web Applications

Hi there! This is the repository containing the slides and examples for a real time web talk. It is composed of two parts:

* MARP slides (https://marp.app/)
* A Phoenix application to host the examples and slides locally (phoenixframework.org)

## Prerequisites

* nodejs (16.13.1)
* elixir (1.14.0-otp-25)
* erlang (25.1.1)
* A running version of postgres
 
I suggest that you use asdf (asdf-vm.com) to manage your versions of installed things. It can handle nearly every language and stack wonderfully, and it's generally a joy to work with.

To set up the slides, do the following:

```bash
cd slides/
npm install
cd ../
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser. The root path for the site is the slide deck, and the examples are embedded. Have fun exploring the app, the slides, and the code!
