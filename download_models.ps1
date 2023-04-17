# YOLO
$uri = "https://drive.google.com/uc?id=1oejmnuTuP_-s7wK100cKiMWa9rwd7Do7&export=download"
$path = "backend/ml/yolo/detect_yolov8x.pt"
Invoke-WebRequest -Uri $uri -OutFile $path

# LaMa
$uri = "https://drive.google.com/uc?id=1lf6rliY2leI7cnEbAQO0NZ08YRg2HktA&export=download"
$path = "backend/ml/lama/models/best.ckpt"
Invoke-WebRequest -Uri $uri -OutFile $path