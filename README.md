# Docusaurus to PDF

This repository allows you to generate a PDF from a Docusaurus documentation URL using Docker or a GitHub Actions workflow.

## Usage

### Using Docker

You can run the tool locally using Docker:

```sh
docker run --rm -e DOCS_URL="https://your-docusaurus-site.com" \
  -e OUTPUT_PDF_FILENAME="docs.pdf" \
  ghcr.io/vaggeliskls/docusaurus-to-pdf:latest
```

### Using GitHub Actions

You can integrate this tool into your GitHub Actions workflow.

#### Example Workflow:

```yaml
name: "Generate PDF from Docusaurus"

on:
  push:

jobs:
  generate-pdf:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Run Docusaurus to PDF Action
        uses: vagggelisksl/docusaurus-to-pdf@latest
        with:
          DOCS_URL: "https://your-docs-url.com"

      - name: Upload PDF Artifact
        uses: actions/upload-artifact@v4
        with:
          name: Docusaurus-PDF
          path: "./docs-to-pdf.pdf"
```

## Customization

You can customize the PDF generation with the following environment variables:

| Variable            | Description                                      | Default Value |
|---------------------|--------------------------------------------------|--------------|
| `DOCS_URL`         | Docusaurus documentation URL (required)          | N/A          |
| `PUPPETEER_ARGS`   | Additional Puppeteer arguments                   | `--no-sandbox` |
| `EXCLUDE_URLS`     | URLs to exclude from the PDF                     | N/A          |
| `EXCLUDE_PATHS`    | Path patterns to exclude                         | N/A          |
| `COVER_TITLE`      | Title for the PDF cover                          | `"Documentation"` |
| `CONTENT_SELECTOR` | CSS selector for main content                    | `"article"` |
| `PAGINATION_SELECTOR` | CSS selector for pagination elements         | `"a.pagination-nav__link.pagination-nav__link--next"` |
| `EXCLUDE_SELECTOR` | CSS selector for elements to exclude             | `".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page"` |
| `EXTRA_ARGS`       | Additional arguments for `docs-to-pdf` command   | N/A          |
| `OUTPUT_PDF_FILENAME` | Custom name for the generated PDF file        | `"docs-to-pdf.pdf"` |

## License

This project is licensed under the [MIT License](LICENSE).

## References

- [doc to pdf](https://github.com/jean-humann/docs-to-pdf)