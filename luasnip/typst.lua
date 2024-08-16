--*******************************************
-- Author:      lcdse7en                    *
-- Gmail:       seenliang969@gmail.com      *
-- Date:        2024-08-07                  *
-- Description:                             *
--*******************************************
--  ISSUE: Gmail: seenliang969@gmail.com to see at YouTube 1190
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local line_begin = require('luasnip.extras.expand_conditions').line_begin
-- local tex = require "utils.latex"

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s(
    {
      trig = 'mytg',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mytg',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #tg.<>(header: "<>")[
        <>
      ]
      ]],
      {
        c(1, { t 'note', t 'warning' }),
        i(2),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'myenu',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myenu',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #for item in (
        "<>",
        "<>",
        "<>",
      ) [+ #item]
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'mypb',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mypb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pagebreak()
      <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = "mynt",
      regTrig = false,
      snippetType = "snippet",
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = "mynt",
      regTrig=false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      //  <>: <>
      ]],
      {
        c(1, { t "NOTE", t"TODO", t "ISSUE"}),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "mytt",
      regTrig = false,
      snippetType = "snippet",
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = "mytt",
      regTrig=false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
        #text(font: "<>")[<>]
      ]],
      {
        c(1, { t "PingFang SC", t "FZShuSong-Z01S", t "Source Han Serif SC", t "NanumMyeongjo"} ),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "myfl",
      regTrig = false,
      snippetType = "snippet",
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = "myfl",
      regTrig=false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
        #let entries = (
          (type: "debit", name: "<>", amount: "<>"),
          (type: "", name: "<>", amount: "<>"),
          (type: "credit", name: "<>", amount: "<>"),
          (type: "", name: "<>", amount: "<>"),
        )
        #journal-entry(entries)
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(8),
      }
    )
  ),
}
