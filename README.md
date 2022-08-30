# github_actions_public

This repository holds reusable Github Action workflows as well as example
callers.

# Required Reading
- [Calling a reusable workflow](https://docs.github.com/en/actions/using-workflows/reusing-workflows#calling-a-reusable-workflow)

# Inputs and Secrets
Inputs and secrets can be passed in from the caller to be used by the called
(i.e. reusable) workflow. You can see what inputs and secrets are used by the
reusable workflow by looking at its `on.workflow_call` section.

# Rails
## Feature Branch Deployments
If the testing process succeeds, the current rails workflow will automatically
deploy to staging environments when a branch is merged into the trunk, but if
you want to deploy a feature branch to staging as well, just include the string
`feature-branch` anywhere in the branch name and the workflow will pick it up
and deploy it.

## Migrating From Jenkins
1. Create a workflow file under `.github/workflows/` and call the reusable
   workflow.
1. `git rm Jenkinsfile`
1. `git mv config/secrets.jenkins.yml config/secrets.github.yml`
  1. You'll also need to change the MySQL/database root password to `root`, as
     the OS for our runners (currently Ubuntu) do not allow a blank password
     for the root user.
