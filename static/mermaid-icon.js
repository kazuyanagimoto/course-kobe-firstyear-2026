mermaid.registerIconPacks([
  {
    name: "simple-icons",
    loader: () =>
      fetch(
        "https://unpkg.com/@iconify-json/simple-icons@1/icons.json",
      ).then((res) => res.json()),
  },
  {
    name: "fa6-brands",
    loader: () =>
      fetch(
        "https://unpkg.com/@iconify-json/fa6-brands@1/icons.json",
      ).then((res) => res.json()),
  },
  {
    name: "fa6-solid",
    loader: () =>
      fetch(
        "https://unpkg.com/@iconify-json/fa6-solid@1/icons.json",
      ).then((res) => res.json()),
  },
]);

// Apply brand colors to icon-shape icons
const iconColors = {
  A: "#75AADB",
  B: "#276DC3",
  C: "#F37626",
  D: "#9558B2",
  F: "#000000",
  G: "#130654",
  H: "#E34F26",
  I: "#FA0F00",
  J: "#2B579A",
  K: "#239DAD",
};
new MutationObserver((_, obs) => {
  const svg = document.getElementById("mermaid-qmd-mermaid");
  if (!svg) return;
  let found = false;
  for (const [node, color] of Object.entries(iconColors)) {
    const g = svg.querySelector('[id^="flowchart-' + node + '-"]');
    if (!g) continue;
    const iconSvg = g.querySelector("svg");
    if (!iconSvg) continue;
    found = true;
    const iconG = iconSvg.closest("g[style]");
    if (iconG) iconG.style.color = color;
  }
  if (found) obs.disconnect();
}).observe(document.body, { childList: true, subtree: true });
