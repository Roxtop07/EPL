// EPL VS Code Extension — LSP Client
// Connects VS Code to EPL's Language Server for diagnostics, completions, and hover.

const vscode = require('vscode');
const { LanguageClient, TransportKind } = require('vscode-languageclient/node');

let client;

function getActiveEPLFile() {
    const editor = vscode.window.activeTextEditor;
    if (!editor || editor.document.languageId !== 'epl') {
        vscode.window.showWarningMessage('Open an .epl file first');
        return null;
    }
    return editor.document.fileName;
}

function runCommandInTerminal(name, command) {
    const terminal = vscode.window.createTerminal(name);
    terminal.sendText(command);
    terminal.show();
}

function activate(context) {
    const config = vscode.workspace.getConfiguration('epl');
    const eplPath = config.get('lsp.path', 'epl');
    const lspEnabled = config.get('lsp.enabled', true);

    // ── LSP Client ──────────────────────────────────
    if (lspEnabled) {
        const serverOptions = {
            command: eplPath,
            args: ['lsp'],
            transport: TransportKind.stdio
        };

        const clientOptions = {
            documentSelector: [{ scheme: 'file', language: 'epl' }],
            synchronize: {
                fileEvents: vscode.workspace.createFileSystemWatcher('**/*.epl')
            }
        };

        client = new LanguageClient(
            'epl-lsp',
            'EPL Language Server',
            serverOptions,
            clientOptions
        );

        client.start();
        context.subscriptions.push(client);
    }

    // ── Run Command ─────────────────────────────────
    const runCommand = vscode.commands.registerCommand('epl.run', () => {
        const filePath = getActiveEPLFile();
        if (!filePath) {
            return;
        }
        runCommandInTerminal('EPL', `${eplPath} run "${filePath}"`);
    });

    // ── Type Check Command ──────────────────────────
    const checkCommand = vscode.commands.registerCommand('epl.check', () => {
        const filePath = getActiveEPLFile();
        if (!filePath) {
            return;
        }
        const strict = config.get('strictMode', false);
        const flags = strict ? ' --strict' : '';
        runCommandInTerminal('EPL Check', `${eplPath} check "${filePath}"${flags}`);
    });

    // ── Format Command ──────────────────────────────
    const formatCommand = vscode.commands.registerCommand('epl.format', () => {
        const filePath = getActiveEPLFile();
        if (!filePath) {
            return;
        }
        runCommandInTerminal('EPL Format', `${eplPath} fmt "${filePath}" --in-place`);
    });

    const compileFile = vscode.commands.registerCommand('epl.compileFile', () => {
        const filePath = getActiveEPLFile();
        if (!filePath) {
            return;
        }
        runCommandInTerminal('EPL Build', `${eplPath} build "${filePath}"`);
    });

    const lintFile = vscode.commands.registerCommand('epl.lintFile', () => {
        const filePath = getActiveEPLFile();
        if (!filePath) {
            return;
        }
        runCommandInTerminal('EPL Lint', `${eplPath} lint "${filePath}"`);
    });

    const profileFile = vscode.commands.registerCommand('epl.profileFile', () => {
        const filePath = getActiveEPLFile();
        if (!filePath) {
            return;
        }
        runCommandInTerminal('EPL Profile', `${eplPath} profile "${filePath}"`);
    });

    const runFile = vscode.commands.registerCommand('epl.runFile', () => {
        vscode.commands.executeCommand('epl.run');
    });

    const formatFile = vscode.commands.registerCommand('epl.formatFile', () => {
        vscode.commands.executeCommand('epl.format');
    });

    context.subscriptions.push(
        runCommand,
        checkCommand,
        formatCommand,
        runFile,
        compileFile,
        formatFile,
        lintFile,
        profileFile
    );

    // ── Status Bar ──────────────────────────────────
    const statusBar = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left, 100);
    statusBar.text = '$(zap) EPL';
    statusBar.tooltip = 'EPL Language Server active';
    statusBar.command = 'epl.run';
    statusBar.show();
    context.subscriptions.push(statusBar);

    console.log('EPL extension v1.0.5 activated');
}

function deactivate() {
    if (client) {
        return client.stop();
    }
}

module.exports = { activate, deactivate };
