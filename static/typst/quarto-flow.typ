#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/iconify:0.5.3": icon, provide-icons

#provide-icons(
  json("icons/simple-icons-subset.json"),
  json("icons/fa6-brands-subset.json"),
  json("icons/fa6-solid-subset.json"),
)

#set page(width: auto, height: auto, margin: 0.5em, fill: none)
#set text(size: 11pt, font: "Fira Sans")

#let brand-node(pos, label, icon-name, color) = node(
  pos,
  stack(
    dir: ttb,
    spacing: 5pt,
    text(fill: color)[#icon(icon-name, height: 2.4em)],
    text(fill: color, weight: "bold", size: 9pt, label),
  ),
  shape: rect,
  fill: rgb(255, 255, 255, 0),
  stroke: rgb(255, 255, 255, 0) + 0.5pt,
  inset: 10pt,
)

#diagram(
  spacing: (2.5em, 3em),
  edge-stroke: 1pt + luma(150),

  // .qmd
  brand-node((0, 2), [.qmd], "simple-icons:quarto", rgb("#75AADB")),

  // Compute engines
  brand-node((1, 1), [knitr], "simple-icons:r", rgb("#276DC3")),
  brand-node((1, 2), [jupyter], "simple-icons:jupyter", rgb("#F37626")),
  brand-node((1, 3), [julia], "simple-icons:julia", rgb("#9558B2")),

  // .md
  brand-node((2, 2), [.md], "fa6-brands:markdown", rgb("#555555")),

  // pandoc
  brand-node((3, 2), [pandoc], "simple-icons:pandoc", rgb("#130654")),

  // Output formats
  brand-node((4, 0.5), [HTML], "simple-icons:html5", rgb("#E34F26")),
  brand-node((4, 1.5), [PDF], "fa6-solid:file-pdf", rgb("#FA0F00")),
  brand-node((4, 2.5), [Microsoft Word], "simple-icons:microsoftword", rgb("#2B579A")),
  brand-node((4, 3.5), [Typst], "simple-icons:typst", rgb("#239DAD")),

  // .qmd -> engines
  edge((0, 2), (1, 1), "->"),
  edge((0, 2), (1, 2), "->"),
  edge((0, 2), (1, 3), "->"),

  // engines -> .md
  edge((1, 1), (2, 2), "->"),
  edge((1, 2), (2, 2), "->"),
  edge((1, 3), (2, 2), "->"),

  // .md -> pandoc
  edge((2, 2), (3, 2), "->"),

  // pandoc -> outputs
  edge((3, 2), (4, 0.5), "->"),
  edge((3, 2), (4, 1.5), "->"),
  edge((3, 2), (4, 2.5), "->"),
  edge((3, 2), (4, 3.5), "->"),
)
