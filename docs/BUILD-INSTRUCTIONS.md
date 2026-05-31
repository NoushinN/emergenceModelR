# Local build instructions

From the package root in RStudio:

``` r
devtools::document()
devtools::test()
devtools::install()
pkgdown::build_site(preview = TRUE)
file.create("docs/.nojekyll")
```

For GitHub Pages, use:

- Settings -\> Pages
- Source: Deploy from a branch
- Branch: main
- Folder: /docs

If `docs/` is ignored by Git, remove `docs` from `.gitignore` and use:

``` bash
git add -f docs
git add .
git commit -m "Build pkgdown site"
git push
```
