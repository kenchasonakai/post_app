import { ready, parse } from '@logue/markdown-wasm';
await ready();

document.addEventListener('turbo:load', () => {
  const markdownArea = document.querySelector('.format');

  if (!markdownArea) return;

  fetch(`${window.location.pathname}.json`)
  .then(response => response.json())
  .then(data => {
    markdownArea.innerHTML = parse(data.content);
  })
  .catch(error => console.error(error));
});