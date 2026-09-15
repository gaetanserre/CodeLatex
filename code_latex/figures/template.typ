// `spacing` is the vertical space between two lines of a code block.
#let config(doc, spacing: 1em) = {
  set raw(
    theme: "catppuccin_latte.thTheme",
    syntaxes: "lean4.sublime-syntax",
  )

  set page(width: auto, height: auto, margin: 1pt)

  show raw: set text(font: ("FiraCode Nerd Font", "JuliaMono"))

  let lean = box(text(font: "Fira Sans", weight: "light", [L$exists forall$N]))

  show raw.where(block: true): it => {
    show regex("\*\*([^*]+)\*\*"): it => {
      let content = it.text.slice(2, -2)
      [\*\*#text(fill: rgb("#d11c41"), weight: "bold", content)\*\*]
    }
    show regex("__([^*]+)__"): it => {
      let content = it.text.slice(2, -2)
      [\_#text(fill: rgb("#d11c41"), style: "italic", content)\_]
    }
    show regex("`([^*]+)`"): it => {
      let content = it.text.slice(1, -1)
      [\`#text(fill: rgb("#599e3c"), style: "italic", content)\`]
    }

    set par(leading: 0.1em, spacing: spacing)

    let lines = {
      for line in it.lines {
        let line_nb = if line.count >= 10 and line.number < 10 {
          " " + str(line.number)
        } else {
          str(line.number)
        }
        align(left, [#text(fill: rgb("#8c9093"), line_nb) #line])
      }
    }

    let lang = {
      if it.lang == "lean4" or it.lang == "lean" {
        lean
      } else if it.lang == "cpp" {
        [C++]
      } else if it.lang != none {
        upper(it.lang.at(0)) + it.lang.slice(1)
      } else {
        none
      }
    }

    let stroke = 1pt + rgb("#d0d7de")

    let lang_block = if lang != none {
      block(
        fill: white,
        stroke: (bottom: stroke, left: stroke, rest: none),
        radius: (top-right: 4pt, rest: 0pt),
        inset: 5pt,
        text(fill: black, lang),
      )
    } else {
      none
    }
    block(
      fill: rgb("#f6f8fa"),
      inset: (right: 0.49pt, rest: 10pt),
      radius: 5pt,
      stroke: stroke,
      grid(
        columns: 2,
        align: top,
        column-gutter: 2em,
        lines,
        [#v(-9.5pt)
          #lang_block
        ],
      ),
    )
    //block(fill: rgb("#f6f8fa"), inset: 5pt, radius: 5pt, stroke: 0.5pt + rgb("#d0d7de"), it)
  }

  doc
}
