importScripts('pyodide/pyodide.js')

let pyodide
let currentId

async function init() {
  pyodide = await loadPyodide({
    indexURL: 'pyodide/',
    stdout: (text) => postMessage({ type: 'stdout', text, id: currentId }),
    stderr: (text) => postMessage({ type: 'stdout', text, id: currentId }),
  })
  postMessage({ type: 'ready' })
}

onmessage = async (e) => {
  if (e.data.type === 'execute') {
    currentId = e.data.id
    try {
      await pyodide.runPythonAsync(e.data.code)
      postMessage({ type: 'done', id: e.data.id })
    } catch (error) {
      postMessage({ type: 'error', message: error.message, id: e.data.id })
    }
  }
}

init()
