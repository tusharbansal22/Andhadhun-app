import cv2
import sys
import face_recognition
import time
import os

known_image = face_recognition.load_image_file('Mentor23.jpg')
known_encoding = face_recognition.face_encodings(known_image)[0]
image_path = r'/Users/tusharbansal/Documents/face_recognition'

faceCascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

video_capture = cv2.VideoCapture(0)
i=0
imatch=0
while True:
    # Capture frame-by-frame
    ret, frame = video_capture.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    faces = faceCascade.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(30, 30),
    )

    # Draw a rectangle around the face
    
    for (x, y, w, h) in faces:
        face = frame[y-180:y + h+180, x-180:x + w+180]
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
        try:
            cv2.imwrite(f'/Users/tusharbansal/Documents/face_recognition/face.jpeg', face)
            unknown_image = face_recognition.load_image_file(f'face.jpeg')
        except:
            continue
        try:
            unknown_encoding = face_recognition.face_encodings(unknown_image)[0]
        except:
            continue

        results = face_recognition.compare_faces([known_encoding], unknown_encoding)
        i+=1
        if(results[0]==True ):
            print('Face Matched')
            sys.exit()
        if(i>2):
            print('Wrong person')
            sys.exit()
        
        os.remove(f'/Users/tusharbansal/Documents/face_recognition/face.jpeg')
    # Display the resulting frame
    cv2.imshow('Video', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()
