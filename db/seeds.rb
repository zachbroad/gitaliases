# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Default Git Aliases
default_aliases = [
  {
    name: "st",
    description: "Short status - shows a concise status with modified, staged, and untracked files",
    code: "status",
    tags: "status, basic, workflow"
  },
  {
    name: "co",
    description: "Checkout shorthand - quickly switch branches or restore files",
    code: "checkout",
    tags: "branch, basic, checkout"
  },
  {
    name: "br",
    description: "Branch shorthand - list, create, or delete branches",
    code: "branch",
    tags: "branch, basic, management"
  },
  {
    name: "ci",
    description: "Commit shorthand - create a new commit with staged changes",
    code: "commit",
    tags: "commit, basic, workflow"
  },
  {
    name: "unstage",
    description: "Remove files from staging area without losing changes",
    code: "reset HEAD --",
    tags: "staging, reset, workflow"
  },
  {
    name: "last",
    description: "Show the last commit with details",
    code: "log -1 HEAD",
    tags: "log, history, info"
  },
  {
    name: "visual",
    description: "Launch gitk to visualize repository history graphically",
    code: "!gitk",
    tags: "visual, gui, history"
  },
  {
    name: "lg",
    description: "Beautiful one-line log with graph, colors, and branch visualization",
    code: "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit",
    tags: "log, visual, history, pretty"
  },
  {
    name: "amend",
    description: "Amend the last commit without changing the commit message",
    code: "commit --amend --no-edit",
    tags: "commit, amend, fix"
  },
  {
    name: "uncommit",
    description: "Undo the last commit but keep changes staged",
    code: "reset --soft HEAD~1",
    tags: "reset, undo, commit"
  },
  {
    name: "alias",
    description: "List all configured git aliases",
    code: "config --get-regexp '^alias\\.'",
    tags: "config, alias, info"
  },
  {
    name: "up",
    description: "Pull with rebase and prune deleted remote branches",
    code: "pull --rebase --prune",
    tags: "remote, sync, rebase"
  },
  {
    name: "wip",
    description: "Create a work-in-progress commit with all changes",
    code: "!git add -A && git commit -m \"WIP\"",
    tags: "workflow, commit, wip"
  },
  {
    name: "undo",
    description: "Undo the last commit and unstage all changes",
    code: "reset HEAD~1 --mixed",
    tags: "reset, undo, commit"
  },
  {
    name: "stash-all",
    description: "Stash all changes including untracked files",
    code: "stash save --include-untracked",
    tags: "stash, workflow, save"
  },
  {
    name: "tree",
    description: "Show a visual tree of commits with branch structure and decorations",
    code: "log --graph --pretty=format:\"%C(red)%h%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%cr) %C(bold blue)<%an>%C(reset)\" --abbrev-commit --all",
    tags: "log, visual, history, tree"
  },
  {
    name: "save",
    description: "Quickly save current work with a descriptive stash message",
    code: "stash push -m",
    tags: "stash, workflow, save"
  },
  {
    name: "pop",
    description: "Apply the most recent stash and remove it from stash list",
    code: "stash pop",
    tags: "stash, workflow, restore"
  },
  {
    name: "find",
    description: "Search for commits containing a specific string in the commit message",
    code: "log --all --grep",
    tags: "search, log, history"
  },
  {
    name: "today",
    description: "Show all commits made today by the current user",
    code: "log --since=\"midnight\" --author=\"$(git config user.name)\" --oneline",
    tags: "log, history, filter, today"
  },
  {
    name: "fresh",
    description: "Create a new branch and switch to it in one command",
    code: "checkout -b",
    tags: "branch, create, workflow"
  },
  {
    name: "cleanup",
    description: "Remove all merged branches except main/master and current branch",
    code: "!git branch --merged | grep -v \"\\*\\|main\\|master\" | xargs -n 1 git branch -d",
    tags: "branch, cleanup, maintenance"
  },
  {
    name: "sync",
    description: "Fetch latest changes and rebase current branch onto origin/main",
    code: "!git fetch origin && git rebase origin/main",
    tags: "remote, sync, rebase"
  },
  {
    name: "fixup",
    description: "Create a fixup commit for the previous commit (useful before interactive rebase)",
    code: "commit --fixup=HEAD",
    tags: "commit, fixup, rebase"
  },
  {
    name: "whoami",
    description: "Display current git user configuration (name and email)",
    code: "!echo \"Name: $(git config user.name)\" && echo \"Email: $(git config user.email)\"",
    tags: "config, info, user"
  }
]

default_aliases.each do |alias_data|
  alias_record = Alias.find_or_create_by!(name: alias_data[:name]) do |record|
    record.description = alias_data[:description]
    record.code = alias_data[:code]
  end
  
  # Add tags if they don't already exist
  if alias_data[:tags] && alias_record.tags.empty?
    alias_record.tag_list = alias_data[:tags]
    alias_record.save!
  end
end
