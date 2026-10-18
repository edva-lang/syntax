# Architecture Notes & Roadmap

These notes summarize the preview pipeline design decisions.

## Lexer State Machine
The highlighter preserves parser states across newline boundaries:
* `STATE_NORMAL`: baseline scanning state
* `STATE_BLOCK_COMMENT`: active C/Rust/JS multi-line comment `/* ... */`
* `STATE_TRIPLE_DOUBLE`: Python `"""` multiline string
* `STATE_TRIPLE_SINGLE`: Python `'''` multiline string
* `STATE_CODE_BLOCK`: Markdown fenced code block

### Key Considerations
1. Avoid quadratic buffer allocation on large lines.
2. UTF-8 character indexing and byte offset synchronicity.
3. Fallback to `LANG_PLAIN` when extension is unrecognized.
