# VS Code Configuration

## Testing Integration

VS Code is configured to run Rails tests through Docker containers.

### Available Test Commands:

1. **Run All Tests**: `Cmd+Shift+T` (or use Command Palette → "Tasks: Run Task" → "Run Rails Tests")
2. **Run Current Test File**: `Cmd+T` when in a test file (or use Command Palette → "Tasks: Run Task" → "Run Single Test File") 
3. **Run Tests via VS Code Testing UI**: Press `F5` when in a test file

### Test Tasks:

- **"Run Rails Tests"** - Runs the full test suite in a separate Docker container
- **"Run Single Test File"** - Runs only the currently open test file in a separate container

### Features:

- ✅ **Isolated test execution** - Tests run in separate containers using `docker compose run --rm`
- ✅ **Debug server compatibility** - Tests disable debug server to avoid port conflicts
- ✅ **Database connectivity** - Tests connect to the shared PostgreSQL container
- ✅ **Keyboard shortcuts** - Quick test execution via VS Code tasks
- ✅ **Clean environment** - Each test run gets a fresh container that's automatically removed

## Debug Integration

VS Code is configured for remote debugging with the Rails app running in Docker.

### Available Debug Commands:

1. **Attach to Debug Server**: Use Debug view (`Cmd+Shift+D`) → Select "Attach to Debug Server" → Press F5
2. **Alternative Terminal Debugging**: Command Palette → "Tasks: Run Task" → "Connect to Debug Server"

### Debug Tasks:

- **"Start Rails Debug Server"** - Manually starts Rails with debug server enabled
- **"Connect to Debug Server"** - Opens interactive debug console in terminal

### Features:

- ✅ **Graphical breakpoints** - Set breakpoints by clicking in gutter
- ✅ **Docker remote debugging** - Debug server runs in container on port 1234
- ✅ **Step debugging** - Step through code, inspect variables
- ✅ **Debug console** - Evaluate expressions during debugging

## File Structure:

- **`.vscode/settings.json`** - Ruby LSP and testing configuration  
- **`.vscode/tasks.json`** - Test and debug tasks for Docker integration
- **`.vscode/launch.json`** - Debug server connection configuration
- **`.vscode/keybindings.json`** - Keyboard shortcuts for testing and debugging