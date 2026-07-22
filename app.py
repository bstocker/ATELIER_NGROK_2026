from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return "Bienvenue dans l'Atelier DevOps — Flask tourne correctement !"

@app.route("/exercices/")
def exercices():
    return render_template("exercices.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
