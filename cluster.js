var clusterMaster = require("cluster-master")

clusterMaster({
  exec: "server.js",
  size: require('os').cpus().length,
  env: process.env,
  args: process.argv.splice(2),
  silent: false,
  signals: true,
})
