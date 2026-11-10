# syntax — Streaming Syntax Highlighting Library for Edva

`syntax` is a streaming syntax highlighting and tokenization library written in [Edva](https://gitea.gde.to/ike/dva). It provides cross-line state-preserving lexers and palette-driven token coloring for CLI viewers, editors, and TUI applications such as [`vade`](../vade/README.md).

---

## Features

- **Cross-Line State Preservation**: Tracks multiline block comments (`STATE_BLOCK_COMMENT`), triple-quoted strings (`STATE_TRIPLE_DOUBLE`, `STATE_TRIPLE_SINGLE`), and fenced Markdown code blocks (`STATE_CODE_BLOCK`) seamlessly across lines.
- **Automatic Language Detection**: Detects language ID from file paths, filenames, or extensions (`syntax::detect_language`).
- **Palette-Driven Coloring**: Integrates directly with `std/color/palette` (`palette::Palette`) to map semantic token classifications (`TOKEN_KEYWORD`, `TOKEN_TYPE`, `TOKEN_STRING`, `TOKEN_NUMBER`, `TOKEN_COMMENT`, `TOKEN_FUNCTION`, `TOKEN_OPERATOR`, `TOKEN_PUNCT`, `TOKEN_SPECIAL`) to 24-bit RGB colors and text attributes (`ATTR_BOLD`, `ATTR_NONE`).
- **Zero External Dependencies**: Pure Edva implementation with fast character-class scanning via `std/ascii`.

---

## Supported Languages

| Language | Extensions / Filenames | ID Constant (`lang::*`) |
| :--- | :--- | :--- |
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

---

## Installation

Add `syntax` to your `edva.ccl`:

```ccl
dependencies =
  syntax =
    path = ../syntax
```

---

## Quick Start

```dva
#use color/palette
#use @syntax

// 1. Detect language from filename
lang_id = syntax::detect_language("src/main.dva")

// 2. Highlight a sequence of lines using a standard palette
pal = palette::TOKYONIGHT
lines = ("// Hello Edva", "main: () => Int", "main = !=> 0")
highlighted = syntax::highlight_lines(lang_id, lines, pal)

// 3. Iterate over highlighted line spans
highlighted @ hline =>
   hline.spans @ span =>
      // span.text -> token substring (String)
      // span.kind -> token classification (TOKEN_KEYWORD, TOKEN_STRING, etc.)
      // span.fg   -> 24-bit RGB foreground color (Int)
      // span.attr -> style attribute flags (ATTR_NONE, ATTR_BOLD)
      <+>
```

For single-line incremental highlighting with explicit state carry-over:

```dva
res = syntax::highlight_line(lang_id, line_str, state_in, pal)
// res.spans     -> syntax::Span{}
// res.state_out -> Int (pass as state_in to the next line)
```

---

## Architecture

- [`src/lang.dva`](src/lang.dva): Language ID constants (`LANG_*`), file extension detection (`detect_language`), and per-language keyword/type tables.
- [`src/token.dva`](src/token.dva): `Span` and `HighlightedLine` record definitions, token classification constants (`TOKEN_*`), lexer state constants (`STATE_*`), and `token_color` / `token_attr` mappers.
- [`src/lex.dva`](src/lex.dva): Streaming state-machine tokenizer (`highlight_line`).
- [`src/syntax.dva`](src/syntax.dva): Top-level public facade (`detect_language`, `token_color`, `highlight_line`, `highlight_lines`).

---

## Running Tests

```bash
cd ~/Z/edva-ware/syntax
edva test
```
