const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');
const chokidar = require('chokidar');

app.allowRendererProcessReuse = true;

if (require('electron-squirrel-startup')) {
  app.quit();
}

const createWindow = () => {
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
    },
  });

  // Open the DevTools for the main window.
  mainWindow.webContents.openDevTools();
  
  mainWindow.loadFile(path.join(__dirname, 'src/index.html'));
  
  const watcher = chokidar.watch(path.join(__dirname));
  watcher.on('change', () => {
    mainWindow.reload();
    // and build the styles.css from tailwind.css
    const exec = require('child_process').exec;
    exec('npm run build:css');
  });
};

app.on('ready', createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});
