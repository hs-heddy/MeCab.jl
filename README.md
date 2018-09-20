# MeCab.jl

[![Build Status](https://travis-ci.org/snthot/MeCab.jl.svg?branch=master)](https://travis-ci.org/snthot/MeCab.jl)

Julia bindings for Japanese morphological analyzer [MeCab](http://mecab.googlecode.com/svn/trunk/mecab/doc/index.html)

## Install

I am not sure if the owner will merge my pull request. However, now, you can install this fork directly to enjoy using the package on Julia 0.7 and 1.0.
In Julia REPL press ']' to enter package manager. Then print the following:

```
add https://github.com/snthot/MeCab.jl.git
```

## Usage

```julia
using MeCab

# Create MeCab tagger
mecab = Mecab()

# You can give MeCab option like "-o wakati"
# mecab = Mecab("-o wakati")

# Parse text
# It returns Array of MecabNode type
results = parse(mecab, "すももももももももものうち")

# Access each result.
# It returns Array of String
for result in results
  println(result.surface, ":", result.feature)
end

# Parse surface
results = parse_surface(mecab, "すももももももももものうち")

# Access each result
# It returns Array of Array of MecabNode
for result in results
  println(result)
end

# Parse nbest result
nbest_results = parse_nbest(mecab, 3, "すももももももももものうち")
for nbest_result in nbest_results
  for result in nbest_result
    println(result.surface, ":", result.feature)
  end
  println()
end

```

## Requirement
- mecab
- dictionary for mecab (such as mecab-ipadic, mecab-naist-jdic, and so on)

If you don't install mecab and libmecab yet, MeCab.jl will install mecab, libmecab and mecab-ipadic that are confirmed to work with MeCab.jl under unix-like environment.

Note that by default, MeCab.jl will try to find system-installed libmecab (e.g. /usr/lib/libmecab.dylib). If you have already libmecab installed, this might cause library or dictionary incompatibility that MeCab.jl assumes. If you have any problem with system-installed ones, please try to ignore them and rebuild MeCab.jl by:

```jl
julia> ENV["MECABJL_LIBRARY_IGNORE_PATH"] = "/usr/lib:/usr/local/lib" # depends on your environment
julia> Pkg.build("MeCab")
```

The libmecab library path will be stored in `MeCab.libmecab` after loading MeCab.jl. The library path should look like for example:

```jl
julia> using MeCab
julia> MeCab.libmecab
"$your_home_dir_path/.julia/v0.4/MeCab/deps/usr/lib/libmecab.dylib"
```

## Credits
September 2018, modified for Julia 1.0 by snthot

MeCab.jl is created by Michiaki Ariga

[MeCab](http://mecab.googlecode.com/svn/trunk/mecab/doc/index.html) by Taku Kudo
