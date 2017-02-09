from skimage.measure import compare_ssim as ssim
import cv2

def compare_two_images(img_a, img_b, threshold=0.95):
    img_1 = cv2.imread(img_a)
    img_2 = cv2.imread(img_b)

    # Convert to gray
    img_1 = cv2.cvtColor(img_1, cv2.COLOR_BGR2GRAY)
    img_2 = cv2.cvtColor(img_2, cv2.COLOR_BGR2GRAY)

    s = ssim(img_1, img_2)

    # print("ssim: %.2f" % s)

    if s >= float(threshold):
        return True
    else:
        return False

def images_should_be_identical(img_a, img_b, threshold=0.95):
    if not compare_two_images(img_a, img_b, threshold):
        raise AssertionError("These two images are not identical!")

def images_should_be_different(img_a, img_b, threshold=0.95):
    if compare_two_images(img_a, img_b, threshold):
        raise AssertionError("These two images are identical!")

def face_detect(image, scaleFactor = 1.1, minNeighbors = 5, minSize = (30, 30)):
    face_cascade = cv2.CascadeClassifier('./haarcascade_frontalface_default.xml') 
    if face_cascade is None:
        raise AssertionError("Can not read haarcascade file!")
    
    # Load image and convert it to grayscale
    image = cv2.imread(image)
    gray  = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # detect faces in the image
    rects = face_cascade.detectMultiScale(gray,
            scaleFactor = scaleFactor, minNeighbors = minNeighbors,
            minSize = minSize, flags = cv2.CASCADE_SCALE_IMAGE)
    
    # Loop over the faces and draw a rectangle around each
    for (x, y, w, h) in rects:
        cv2.rectangle(image, (x, y), (x + w, y + h), (0, 255, 0), 2)

    # Save the image
    cv2.imwrite('./Face_detect.jpg', image)

    return rects

def there_should_be_face_in_image(image):
    face_rects = face_detect(image)
    
    if face_rects is None:
        raise AssertionError("No face in the image!")


