# github_actions_public

This repository holds reusable Github Action workflows as well as example
callers.

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
