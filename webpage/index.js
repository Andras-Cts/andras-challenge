fetch("https://andras-backend-test-296888346216.europe-west1.run.app")
  .then(res => res.json())
  .then(data => document.getElementById("visitor").innerHTML = `${data.count}`);
