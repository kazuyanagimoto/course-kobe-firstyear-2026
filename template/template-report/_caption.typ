#show figure.caption: it => block(width: 100%, {
  set align(left)
  set text(size: 9pt)
  show strong: s => text(size: 11pt, s.body)
  it
})
