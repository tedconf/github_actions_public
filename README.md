# github_actions_public

This repository holds reusable Github Action workflows as well as example
callers.

# Required Reading
- [Calling a reusable workflow](https://docs.github.com/en/actions/using-workflows/reusing-workflows#calling-a-reusable-workflow)

# Inputs and Secrets
Inputs and secrets can be passed in from the caller to be used by the called
(i.e. reusable) workflow. You can see what inputs and secrets are used by the
reusable workflow by looking under its `on.workflow_call` section.

# Rails
The full workflow for a Rails app involves both CI and CD jobs, where CI
involves tests and static analyses and CD involves deployments. Your client app
can call the full workflow by including this line in your workflow file:

```
uses: tedconf/github_actions_public/.github/workflows/rails.yml@{git ref}
```

The variable `{git ref}` can refer to a SHA, tag, or branch name.

## rails_ci.yml
This workflow runs two workflows in parallel:

- rails_ci_static_analyses
- rails_ci_tests

This workflow is also meant to handle and/or install certain system
dependencies through the [setup-ruby](https://github.com/tedconf/setup-ruby)
and
[install-ruby-dependency-action](https://github.com/tedconf/install-ruby-dependency-action),
composite actions, although these dependencies need to be added manually and
specific requirements might be missing.

One requirement that is currently supported and also warrants highlighting is
the suite of coyote integration tests, which need an Elasticsearch docker
container to pass. This workflow both detects if coyote tests need to be run
and if so, sets up ES automatically for you. 

## rails_cd.yml
Currently this workflow deploys to staging whenever `master` or `main` are updated.

Future features include:
- Production deployments
- Feature branch teardown

## Ruby Gems
If your repo is **not** a full Rails application and is instead a Ruby Gem, you
can use the `rails_ci` workflow instead:

```
uses: tedconf/github_actions_public/.github/workflows/rails_ci.yml@{git ref}
```

## Feature Branch Deployments
If the testing process succeeds, the current rails workflow will automatically
deploy to staging environments when a branch is merged into the trunk, but if
you want to deploy a feature branch to staging as well, just include the string
`fbranch` anywhere in the branch name and the workflow will pick it up and
deploy it.

## Migrating From Jenkins
1. Create a workflow file under `.github/workflows/` and call the reusable
   workflow.
1. `git rm Jenkinsfile`
1. `git mv config/secrets.jenkins.yml config/secrets.github.yml`. You'll also
   need to change the MySQL/database root password to `root`, as the OS for our
   runners (currently Ubuntu) do not allow a blank password for the root user.
