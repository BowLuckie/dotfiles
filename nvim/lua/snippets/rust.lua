local ls = require("luasnip")
local postfix = require("luasnip.extras.postfix").postfix
local f = ls.function_node

local function get_match(_, snip)
  return (snip.env and snip.env.POSTFIX_MATCH) or (snip.trigger and snip.trigger:match("^(.*)%.%w+$")) or ""
end

return {
  postfix(".opt", {
    f(function(_, snip)
      return "Option<" .. get_match(_, snip) .. ">"
    end, {}),
  }),

  postfix(".res", {
    f(function(_, snip)
      return "Result<" .. get_match(_, snip) .. ", Error>"
    end, {}),
  }),
}
