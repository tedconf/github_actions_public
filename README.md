# github_actions_public

This repository holds reusable Github Action workflows as well as example
callers.

# Required Reading
- [Calling a reusable workflow](https://docs.github.com/en/actions/using-workflows/reusing-workflows#calling-a-reusable-workflow)

# Inputs and Secrets
Inputs and secrets can be passed in from the caller to be used by the called
(i.e. reusable) workflow. You can see what inputs and secrets are used by the
reusable workflow by looking under its `on.workflow_call` section. Generally,
the syntax is as follows:

```
  uses: <reusable workflow file>
  with:
    <parameter name>: <value>
```

# Rails
The full workflow for a Rails app involves both CI and CD jobs, where CI
involves tests and static analyses and CD involves deployments. Your client app
can call the full workflow by including this line in your workflow file:

```
uses: tedconf/github_actions_public/.github/workflows/rails.yml@{git ref}
```

The variable `{git ref}` can refer to a SHA, tag, or branch name.

## Continuous Integration (rails_ci.yml)
This workflow runs two workflows in parallel:

- rails_ci_static_analyses
- rails_ci_tests

It is also meant to handle and/or install certain system dependencies through
the [setup-ruby](https://github.com/tedconf/setup-ruby) and
[install-ruby-dependency-action](https://github.com/tedconf/install-ruby-dependency-action)
composite actions, although these dependencies need to be added manually and
specific requirements might be missing.

One requirement that is currently supported and also warrants highlighting is
the suite of coyote integration tests, which need an Elasticsearch docker
container to pass. This workflow both detects if coyote tests need to be run
and if so, sets up ES automatically for you.

### rails_ci_static_analyses

#### Ignoring CVEs
In the event that your client repo needs to ignore any CVEs, you can pass them
into the workflows as `cve-ignorelist` inputs, e.g.:

```
  uses: <reusable workflow file>
  with:
    cve-ignorelist: 'CVE-1 CVE-2 ...'

```

## Continuous Deployment (rails_cd.yml)
Currently this workflow:
- deploys to **staging** whenever `master` or `main` are updated;
- deploys feature branches to **staging**
  ([details](#feature-branch-deployments));
- as of v2.0.0, deploys to **production** whenever a tag using a
  `YYYYMMDD_HHmm` format is pushed ([details](#production-deployments)).

### Feature Branch Deployments
Any feature branch that includes the string `fbranch` anywhere in its branch
name will deploy to staging.

**NOTE**: Feature branch teardown isn't supported yet, so for the time being,
this responsibility still falls on the developer.

### Production Deployments
For any repo that includes the `rails_cd.yml` workflow with a version of at
least `v2.0.0`, production deployments happen via `ted-capistrano3` when tags
in with the `YYYYMMDD_HHmm` format are pushed. The time component is in 24-hour
UTC time (e.g. `20221027_2255`), and you can optionally include seconds in the
tag, e.g. `20221027_225544`.

### Future Features
- Feature branch teardown
- ted-capistrano recipe to make tagging easier

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
