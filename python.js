importScripts('pyodide/pyodide.js')

let pyodide
let currentId

async function init() {
  pyodide = await loadPyodide({
    indexURL: 'pyodide/',
  })
  pyodide.setStdout({
    batched: (text) => postMessage({ type: 'stdout', text: text + '\n', id: currentId }),
  })
  pyodide.setStderr({
    batched: (text) => postMessage({ type: 'stdout', text: text + '\n', id: currentId }),
  })
  postMessage({ type: 'ready' })
}

onmessage = async (e) => {
  if (e.data.type === 'execute') {
    currentId = e.data.id
    try {
      let result = await pyodide.runPythonAsync(e.data.code)
      if (result !== undefined && result !== null) {
        let text = String(result)
        if (text !== 'None') {
          postMessage({ type: 'stdout', text: text + '\n', id: e.data.id })
        }
        if (typeof result === 'object' && typeof result.destroy === 'function') {
          result.destroy()
        }
      }
      postMessage({ type: 'done', id: e.data.id })
    } catch (error) {
      postMessage({ type: 'error', message: error.message, id: e.data.id })
    }
  }
}

init()
