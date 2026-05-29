# fortunes-biofx

A `fortune` cookie pack for bioinformatics labs. Equal parts hard-won wisdom,
real quotes, and the quiet despair of `conda activate`.

```
$ fortune biofx
Your BLAST hit was a contaminant.
The E-value was lying to you.
```

## What's in the box

| File           | Contents                                              |
|----------------|-------------------------------------------------------|
| `biofx`        | Lab humor: clusters, pipelines, reviewer 2, off-by-one |
| `biofx-quotes` | Real quotes from biology, stats, and computing         |
| `biofx-local`  | Quotes from *our own* professors and PIs — add yours!  |

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
fortune biofx         # a lab joke
fortune biofx-quotes  # a real quote
fortune biofx-local   # something a professor actually said
```

If `make` can't find your fortune directory, point it at the right one:

```sh
make install FORTUNE_DIR=/usr/local/share/games/fortunes
```

No root? Keep everything local and run from this directory:

```sh
make            # build the .dat index files here
fortune .       # draw from all files in the current dir
fortune ./biofx # draw from one file
```

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
