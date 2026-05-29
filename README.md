# fortunes-lab

A `fortune` cookie pack for bioinformatics labs. Equal parts hard-won wisdom,
real quotes, and the quiet despair of `conda activate`.

```
$ fortune lab
Your BLAST hit was a contaminant.
The E-value was lying to you.
```

## What's in the box

| File           | Contents                                              |
|----------------|-------------------------------------------------------|
| `lab`          | Lab humor: clusters, pipelines, reviewer 2, off-by-one |
| `lab-quotes`   | Real quotes from biology, stats, and computing         |
| `lab-local`    | Quotes from *our own* professors and PIs — add yours!  |

## Install

Requires the `fortune` program (which ships `strfile`):

```sh
# Debian/Ubuntu
sudo apt install fortune-mod
# macOS
brew install fortune
# Fedora
sudo dnf install fortune-mod
```

Then:

```sh
make install          # compiles + installs into the system fortune dir
fortune lab           # a lab joke
fortune lab-quotes    # a real quote
fortune lab-local     # something a professor actually said
```

If `make` can't find your fortune directory, point it at the right one:

```sh
make install FORTUNE_DIR=/usr/local/share/games/fortunes
```

No root? Keep everything local and run from this directory:

```sh
make                  # build the .dat index files here
fortune "$PWD"        # draw from all files in this dir
fortune "$PWD/lab"    # draw from one file
```

> Heads up: `fortune-mod` resolves a *bare* relative argument (`.`, `./lab`)
> against the **system** fortune directory, not your shell's `cwd` — so for a
> local checkout pass an **absolute** path (`"$PWD/..."`) as shown above.
> `make test` does this for you.

## Adding fortunes

Each entry is plain text. Separate entries with a line containing **only** `%`:

```
A wise PI once said: "Just align it to the genome."
%
The cluster is down. The cluster is always down.
%
```

Real quotes use a tab-indented attribution line:

```
Nothing in biology makes sense except in the light of evolution.
		-- Theodosius Dobzhansky
%
```

After editing, run `make` to rebuild the `.dat` indexes (then `make install`
again if you've installed system-wide). `make clean` removes the indexes.

## Uninstall

```sh
make uninstall
```
