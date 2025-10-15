# GitHub Copilot Custom Instructions

## Preferences GitHub Copilot Should Follow
- Keep responses concise and to the point.
  - Do not hallucinate or use filler words.
  - All facts must be accurate and verifiable.
- Use clear and simple language.
  - Don't use complex jargon.
  - Don't add unnecessary details.
  - Don't express emotions or use emojis.
- Always run `git status` before working on your given task to understand the git state of this repo first, eg: current branch name, changes to commit, unstaged, untracked files.

## Instructions for Copilot Coding Agent
If the user says you are "Copilot Coding Agent" or the current branch name is prefixed with `copilot/`, you must follow the instructions in this section:

- Be mindful of your current working directory, change to the project workspace directory `$GITHUB_WORKSPACE` if necessary.
- Prefer to use the GitHub MCP server tool instead of the CLI `gh`
- You have access to a devcontainer environment, which contains all the necessary tools and dependencies to run the code, such as:
  - Bash tools:  `go`, `docker`, `git`, `nslookup`, `psql`, `redis-cli`, `tmux`, `inotifywait` etc.
  - Node ecosystem tools: `node`, `npm`, `pnpm`, `yarn`, `npx`, etc.
  - Python ecosystem tools: `python3`, `pip`, `uv`, `uvx`, `pre-commit`, etc.
  - Go ecosystem tools: `go`, `gofmt`, `golangci-lint`, `protoc`, etc.
  - AI Agent CLI: `claude`
- Use `claude --max-turns 100 --allowedTools "Task, Bash, BashOutput, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookRead, NotebookEdit, WebFetch, TodoWrite, WebSearch, ListMcpResourcesTool, ReadMcpResourceTool, mcp__gosu, mcp__sequential-thinking, mcp__context7" -p "<your prompt>"` when you need to:
  - Make a plan to achieve a specific task
  - Review the source code files you created/modified
  - Fix a complicated issue/bug/error
  - Review specification files (*.spec.md) against the original design document
  - Brainstorm ideas or project new features
  - User explicitly requests you to ask/use `claude` to do something
- If `claude` requires an answer/interaction from you, or you simply want it to continue working the unfinished task. You must add `--continue` to the next command to continue the conversation. For example: `claude --max-turns 100 --allowedTools "Task, Bash, BashOutput, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookRead, NotebookEdit, WebFetch, TodoWrite, WebSearch, ListMcpResourcesTool, ReadMcpResourceTool, mcp__gosu, mcp__sequential-thinking, mcp__context7" -p "yes, proceed to complete the task" --continue`
- AI Agent CLI such as: `claude` may take a while to respond, so you must not abort the bash command before attempting `read_bash` for at least 15 times (read with time out of 60 seconds each).
  - Don't give multiple tasks to AI Agent CLI at the same time, always do it one by one. Only prompt for the next task after the previous one is completed. This will help AI Agent to avoid confusion and reduce the time it takes to respond back to you.
  - Consider breaking down a complex task into smaller step by step tasks and then use option `--continue` to continue the conversation with `claude` for each step.

- Always use `devcontainer exec --workspace-folder $GITHUB_WORKSPACE [command to run]` to run bash commands in the devcontainer; do not execute commands on the host machine. For example:
  - `docker compose up -d` -> `devcontainer exec --workspace-folder $GITHUB_WORKSPACE docker compose up -d`
  - `pnpm install` -> `devcontainer exec --workspace-folder $GITHUB_WORKSPACE pnpm install`
  - `claude --max-turns 100 --allowedTools "Task, Bash, BashOutput, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookRead, NotebookEdit, WebFetch, TodoWrite, WebSearch, ListMcpResourcesTool, ReadMcpResourceTool, mcp__gosu, mcp__sequential-thinking, mcp__context7" -p "review all *.spec.md files against its original design"` -> `devcontainer exec --workspace-folder $GITHUB_WORKSPACE claude --max-turns 100 --allowedTools "Task, Bash, BashOutput, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookRead, NotebookEdit, WebFetch, TodoWrite, WebSearch, ListMcpResourcesTool, ReadMcpResourceTool, mcp__gosu, mcp__sequential-thinking, mcp__context7" -p "review all *.spec.md files against its original design"`
- When running bash commands with `devcontainer exec --workspace-folder $GITHUB_WORKSPACE`, the current working directory is already set to the project workspace directory, so you can use relative paths in your commands.
