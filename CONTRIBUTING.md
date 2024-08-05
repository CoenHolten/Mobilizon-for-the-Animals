Please read our full contributing document at [https://docs.joinmobilizon.org/contribute/](https://docs.joinmobilizon.org/contribute/)

setup guide:
- get apollo and vue plugins for your browser
- install erlang and elixir using asdf (.tool-versions)
- install elixir lsp plugin in vscode
- make sure deps folder is not owned by root and run `mix deps.get`
- install docker (outside wsl)
- run docker with `make start`


updating the dependencies is something like:
- nix deps.update --all
- `nix deps.nix` and then move the deps.nix file to nix/deps.nix