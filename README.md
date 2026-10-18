# syntax

Streaming syntax highlighting and tokenization library for [Edva](https://github.com/edva-lang/edva).

## Features

- **Multi-Language Lexing**: Built-in tokenizers with cross-line state preservation (handles multiline comments, raw strings, block quotes).
- **Automatic Language Detection**: Detects language by filename or file extension (`.dva`, `.rs`, `.c`, `.py`, `.go`, `.zig`, etc.).
- **Palette & Theme Driven**: Resolves tokens into RGB colors using customizable palettes (e.g. Catppuccin Mocha/Latte, ANSI, standard terminal colors).
- **Zero Heavy Dependencies**: Pure Edva implementation designed for CLI viewers, editors, and TUI applications.

## Supported Languages

| Language | Extensions / Filenames | ID Constant |
|---|---|---|
| **Edva** | `.dva` | `LANG_EDVA` |
| **Rust** | `.rs` | `LANG_RUST` |
| **C / C++** | `.c`, `.h`, `.cpp`, `.cc`, `.cxx`, `.hpp` | `LANG_C`, `LANG_CPP` |
| **Go** | `.go` | `LANG_GO` |
| **Zig** | `.zig` | `LANG_ZIG` |
| **Python** | `.py` | `LANG_PYTHON` |
| **Shell** | `.sh`, `.bash`, `.zsh` | `LANG_SHELL` |
| **JavaScript / TypeScript** | `.js`, `.mjs`, `.ts`, `.tsx`, `.jsx` | `LANG_JS`, `LANG_TS` |
| **Odin** | `.odin` | `LANG_ODIN` |
| **Nushell** | `.nu` | `LANG_NUSHELL` |
| **JSON** | `.json` | `LANG_JSON` |
| **TOML** | `.toml` | `LANG_TOML` |
| **CCL** | `.ccl` | `LANG_CCL` |
| **Markdown** | `.md` | `LANG_MARKDOWN` |
| **HTML** | `.html`, `.htm` | `LANG_HTML` |
| **Diff** | `.diff`, `.patch` | `LANG_DIFF` |
| **Makefile** | `Makefile`, `makefile`, `.mk` | `LANG_MAKEFILE` |

## Installation

Add to your `edva.ccl`:

```ccl
dependencies =
  syntax =
    git = "https://github.com/edva-lang/syntax"
    rev = "v0.1.0"
```

## Quick Start

```edva
#use "syntax"
#use "color/palette"

// Detect language
lang = syntax::detect_language("src/main.dva")

// Highlight a sequence of lines using a palette
pal = palette::catppuccin_mocha()
lines = ("// Hello Edva", "main = !=> 0")
highlighted = syntax::highlight_lines(lang, lines, pal)

// Iterate over highlighted line spans
highlighted @ hline =>
   hline.spans @ span =>
      // span.str   -> token text
      // span.color -> 24-bit RGB integer
      // span.kind  -> token kind (KEYWORD, STRING, COMMENT, etc.)
```

## Architecture

- [`src/lang.dva`](src/lang.dva): Language IDs, file extension associations, and keyword tables.
- [`src/token.dva`](src/token.dva): Token definitions (`Span`, `HighlightedLine`, token kinds, and palette color mapping).
- [`src/lex.dva`](src/lex.dva): Streaming tokenizer with state persistence across lines (`state_in` / `state_out`).
- [`src/syntax.dva`](src/syntax.dva): High-level public facade.

## License

BSD-2-Clause
