from flask import Flask, request, jsonify

app = Flask(__name__)

students = []

@app.route("/")
def home():
    return jsonify({
        "message": "Flask Backend is Running",
        "status": "success"
    })

@app.route("/health")
def health():
    return jsonify({
        "health": "OK"
    })

@app.route("/students", methods=["GET"])
def get_students():
    return jsonify(students)

@app.route("/students", methods=["POST"])
def add_student():
    data = request.get_json()

    student = {
        "name": data.get("name"),
        "course": data.get("course")
    }

    students.append(student)

    return jsonify({
        "message": "Student Added Successfully",
        "student": student
    }), 201


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )
