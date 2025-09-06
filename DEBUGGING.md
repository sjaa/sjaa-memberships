# VS Code + Docker Debugging Setup

This Rails application is configured for remote debugging with VS Code while running in Docker.

## Quick Start

1. **Install Required VS Code Extension:**
   - Install "VSCode rdbg Ruby Debugger" (koichisasada.vscode-rdbg)

2. **Start your Docker containers:**
   ```bash
   docker compose up
   ```

3. **The debug server will automatically start on port 1234**
   You should see in the logs:
   ```
   🐛 Starting debug server on 0.0.0.0:1234
   DEBUGGER: Debugger can attach via TCP/IP (0.0.0.0:1234)
   ```

4. **In VS Code:**
   - Set breakpoints by clicking in the gutter next to line numbers
   - Press `Ctrl+Shift+D` (or `Cmd+Shift+D` on Mac) to open Debug view
   - Select "Attach to Debug Server" from the dropdown
   - Press F5 or click the green play button
   
   **For graphical breakpoints to work:**
   - After connecting, VS Code breakpoints should work automatically
   - If breakpoints don't trigger, add `debugger` statements in your code as fallback
   
   **Alternative: Use VS Code Tasks for Debugging:**
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Type "Tasks: Run Task"
   - Select "Connect to Debug Server" for interactive debugging

4. **Add breakpoints in your code:**
   ```ruby
   def some_method
     debugger  # This will pause execution here
     # Your code here
   end
   ```

## Debug Configurations Available

- **"Attach to Debug Server"** - Simple configuration that connects to debug server on port 1234

## VS Code Tasks Available  

- **"Start Rails Debug Server"** - Starts Rails with debug server enabled
- **"Connect to Debug Server"** - Opens interactive debug console in terminal

## Manual Debug Start (if needed)

If automatic debug server doesn't work, start manually:

```bash
# Start Rails with debug server
docker container exec -it sjaa-memberships-app-1 bin/rails-debug

# Or use rdbg directly
docker container exec -it sjaa-memberships-app-1 bundle exec rdbg --open --host 0.0.0.0 --port 1234 -- bin/rails server -b 0.0.0.0
```

## Troubleshooting

### "Couldn't find a workspace" Error

This error typically means VS Code can't map the workspace properly. Try these steps:

1. **Install Required Extensions:**
   ```
   - Ruby LSP (Shopify.ruby-lsp)
   - VSCode rdbg Ruby Debugger (koichisasada.vscode-rdbg)
   ```

2. **Open VS Code to the Project Root:**
   - Make sure VS Code is opened to `/Users/csvensson/Documents/Git/sjaa-memberships` (not a parent or child directory)
   - The `.vscode` folder should be visible in VS Code's file explorer

3. **Restart VS Code and Docker:**
   ```bash
   # Restart containers
   docker compose restart
   
   # Restart VS Code completely
   ```

4. **Try the Simple Debug Configuration:**
   - Use "Connect to Debug Server" instead of "Attach to Rails (Docker)"
   - This has fewer path mapping requirements

### Other Common Issues

- **Port 1234 already in use?** Kill the process: `lsof -ti:1234 | xargs kill`
- **Can't connect?** Restart containers: `docker compose restart`
- **No debug gem?** Check: `docker container exec sjaa-memberships-app-1 gem list debug`
- **Debug server not starting?** Check logs: `docker compose logs app`

## Debug Features

- ✅ Set breakpoints in VS Code
- ✅ Step through code (step in, step over, step out)
- ✅ Inspect variables and call stack
- ✅ Debug console for evaluating expressions
- ✅ Watch expressions
- ✅ Conditional breakpoints

Happy debugging! 🐛🔍