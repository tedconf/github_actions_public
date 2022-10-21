# 2.0.1 (2022-10-21)
- Updates output variable syntax again, which [Github changed
  AGAIN](https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/)
- Adds `--force` option to brakeman for Gem repos that have it installed 

# 2.0.0 (2022-10-19)
- Adds support to trigger production deployments based on `MMMMYYDD_HHMM` tag
  format

# 1.2.1 (2022-10-17)
- Separates main and feature branch deployments to improve capistrano
  compatibility issues (not all repos have cap that supports branch deployment)

# 1.2.0 (2022-10-13)
- Updates variable syntax per [Github
  docs](https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/)

# 1.1.0 (2022-10-11)
- Adds support for ruby gem CI:
  - Adds conditionals for:
    - db creation
    - brakeman
  - Fixes support for ruby version matrix

# 1.0.1 (2022-10-11)
- Adds `main` branch to CD workflows

# 1.0.0 (2022-10-10)
- Separates CI and CD by moving workflows into separate (nested) ymls
- Within CI workflows, splits static analyses (audit, rubocop) from unit tests
- Fixes installation of system dependencies by bumping `setup-ruby` to 1.0.2
