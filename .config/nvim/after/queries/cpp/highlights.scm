; extends

((declaration
    declarator: (init_declarator
        declarator: (identifier) @constant))
 (#match? @constant "^[A-Z][A-Z0-9_]*$"))
