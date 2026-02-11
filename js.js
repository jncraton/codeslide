onmessage = async (e) => {
  if (e.data.type === 'execute') {
    const id = e.data.id
    const oldLog = console.log
    console.log = (...args) => {
      postMessage({
        type: 'stdout',
        text: args.map((arg) => String(arg)).join(' ') + '\n',
        id,
      })
    }
    try {
      const result = eval(e.data.code)
      if (result !== undefined && result !== null) {
        postMessage({ type: 'stdout', text: String(result) + '\n', id })
      }
      postMessage({ type: 'done', id })
    } catch (error) {
      postMessage({ type: 'error', message: error.stack || error.message, id })
    } finally {
      console.log = oldLog
    }
  }
}
