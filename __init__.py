from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def hello_world():
    msg = "<h2>Bonjour tout le monde !</h2>"
    msg += "<p>Pour accéder à vos exercices cliquez "
    msg += "<a href='./exercices/'>Ici</a></p>"
    return msg


@app.route("/exercices/")
def exercices():
    return render_template("exercices.html")


if __name__ == "__main__":
    app.run(debug=True)
