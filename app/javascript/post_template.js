document.addEventListener('turbo:load', () => {
  (async () => {
    const response = await fetch('/post_templates.json');
    const templates = await response.json();
    const templateSelect = document.querySelector('select[name="post[template]"]');
    const contentTextarea = document.querySelector('textarea[name="post[content]"]');
    if (templateSelect && contentTextarea) {
      templateSelect.addEventListener('change', (event) => {
        const templateId = event.target.value;
        const template = templates.find((template) => template.id == templateId);
        contentTextarea.value = template.content;
      });
    }

    templates.forEach((template) => {
      templateSelect.appendChild(createTemplateOption(template));
    });
  })();

  const createTemplateOption = (template) => {
    const option = document.createElement('option');
    option.value = template.id;
    option.textContent = template.title;
    return option;
  }
});