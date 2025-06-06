from flask import Flask, request, jsonify
import os
import cv2
import dlib
import numpy as np

app = Flask(__name__)
import random

# Banco de dados de cortes de cabelo (simplificado)
haircut_database = {
    "oval": [
        {"name": "Corte bob", "style": "elegante", "maintenance": "média"},
        {"name": "Franja lado", "style": "moderno", "maintenance": "baixa"},
    ],
    "redondo": [
        {"name": "Undercut", "style": "arrojado", "maintenance": "alta"},
        {"name": "Camadas longas", "style": "clássico", "maintenance": "média"},
    ],
    "quadrado": [
        {"name": "Curtinho pixie", "style": "moderno", "maintenance": "baixa"},
        {"name": "Ondas soltas", "style": "romântico", "maintenance": "alta"},
    ],
    "alongado": [
        {"name": "Franja grossa", "style": "juvenil", "maintenance": "média"},
        {"name": "Corte lob", "style": "elegante", "maintenance": "média"},
    ],
    "triangular": [
        {"name": "Camadas médias", "style": "natural", "maintenance": "média"},
        {"name": "Raspado nas laterais", "style": "ousado", "maintenance": "alta"},
    ]
}

def recommend_haircut(face_shape, preferences=None):
    if face_shape not in haircut_database:
        return None
    
    # Filtros baseados em preferências (simplificado)
    candidates = haircut_database[face_shape]
    
    if preferences:
        if "style" in preferences:
            candidates = [h for h in candidates if h["style"] == preferences["style"]]
        if "maintenance" in preferences:
            candidates = [h for h in candidates if h["maintenance"] == preferences["maintenance"]]
    
    # Retorna 3 recomendações aleatórias (ou menos se não houver muitas opções)
    return random.sample(candidates, min(3, len(candidates)))


# Inicializar detectores
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")

def analyze_face_shape(image_path):
    # Carregar imagem
    image = cv2.imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # Detectar rostos
    faces = detector(gray)
    if not faces:
        return None
    
    # Pegar o primeiro rosto
    face = faces[0]
    
    # Obter landmarks faciais
    landmarks = predictor(gray, face)
    landmarks_points = np.array([(landmarks.part(n).x, landmarks.part(n).y) for n in range(68)])
    
    # Calcular proporções para determinar o formato
    jaw_width = landmarks_points[16][0] - landmarks_points[0][0]
    face_height = landmarks_points[8][1] - landmarks_points[19][1]
    forehead_width = landmarks_points[21][0] - landmarks_points[17][0]
    cheekbone_width = landmarks_points[14][0] - landmarks_points[2][0]
    
    # Determinar formato do rosto
    ratio = jaw_width / face_height
    
    if ratio > 0.75:
        if cheekbone_width > forehead_width and cheekbone_width > jaw_width:
            return "redondo"
        else:
            return "quadrado"
    elif ratio < 0.65:
        return "alongado"
    else:
        if forehead_width > cheekbone_width and cheekbone_width > jaw_width:
            return "triangular"
        else:
            return "oval"

# Exemplo de uso
face_shape = analyze_face_shape("user_photo.jpg")



@app.route('/analyze', methods=['POST'])
def analyze():
    if 'file' not in request.files:
        return jsonify({"error": "Nenhum arquivo enviado"}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "Nome de arquivo vazio"}), 400
    
    # Salvar arquivo temporariamente
    temp_path = os.path.join("/tmp", file.filename)
    file.save(temp_path)
    
    # Analisar rosto
    face_shape = analyze_face_shape(temp_path)
    if not face_shape:
        return jsonify({"error": "Nenhum rosto detectado"}), 400
    
    # Obter preferências (se enviadas)
    preferences = request.form.to_dict()
    
    # Recomendar cortes
    recommendations = recommend_haircut(face_shape, preferences)
    
    # Limpar arquivo temporário
    os.remove(temp_path)
    
    return jsonify({
        "face_shape": face_shape,
        "recommendations": recommendations
    })

if __name__ == '__main__':
    app.run(debug=True)