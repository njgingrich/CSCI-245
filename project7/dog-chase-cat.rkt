(require 2htdp/universe)
(require 2htdp/image)

; constants
(define DOG (bitmap/file "dog.gif"))

(define CAT .)
(define WIDTH 400)
(define HEIGHT 400)
(define DELTA 3)
(define SCENE (empty-scene WIDTH HEIGHT))

; data structures
(define-struct position
  [x y]
)

(define-struct world
  [cat dog]
)

; helper functions
(define (half-width img)
  (ceiling (/ (image-width img) 2))
)

(define (half-height img)
  (ceiling (/ (image-height img) 2))
)

(define (image/left img position)
  (make-position
    (- (position-x position) (half-width img))
    (position-y position)
  )
)

(define (image/right img position)
  (make-position
    (+ (position-x position) (half-width img))
    (position-y position)
  )
)

(define (image/top img position)
  (make-position
    (position-x position)
    (- (position-y position) (half-height img))
  )
)

(define (image/bottom img position)
  (make-position
    (position-x position)
    (+ (position-y position) (half-height img))
  )
)

; range functions

(define (keep-in-range value min max)
  (cond
    [(< value min) min]
    [(> value max) max]
    [else value]
  )
)

; test keep-in-range
(check-expect (keep-in-range 400 300 500) 400)
(check-expect (keep-in-range 400 500 700) 500)
(check-expect (keep-in-range 200 16 99) 99)

(define (keep-in-world image position)
  (make-position
     (keep-in-range (position-x position) (half-width image) (- WIDTH (half-width image)))
     (keep-in-range (position-y position) (half-width image) (- HEIGHT (half-width image)))
   )
)

; test keep-in-world
(check-expect (keep-in-world CAT (make-position 0 (/ WIDTH 2)))
              (make-position (half-width CAT) (/ WIDTH 2)))
(check-expect (keep-in-world CAT (make-position (/ WIDTH 2) 0))
              (make-position (/ WIDTH 2) (half-width CAT)))
(check-expect (keep-in-world CAT (make-position 0 0))
              (make-position (half-width CAT) (half-width CAT)))
(check-expect (keep-in-world CAT (make-position WIDTH HEIGHT))
              (make-position (- WIDTH (half-width CAT)) (- HEIGHT (half-width CAT))))

(define (images/overlap? image1 position1 image2 position2)
  (cond
    [(> (position-x (image/left image1 position1)) (position-x (image/right image2 position2))) #false]
    [(> (position-x (image/left image2 position2)) (position-x (image/right image1 position1))) #false]
    [(> (position-y (image/top image1 position1)) (position-y (image/bottom image2 position2))) #false]
    [(> (position-y (image/top image2 position2)) (position-y (image/bottom image1 position1))) #false]
    [else #true]
  )
)

; big-bang functions
(define (render world)
    (place-images (list CAT
                        DOG)
                  (list (make-posn (position-x (world-cat world)) (position-y (world-cat world)))
                        (make-posn (position-x (world-dog world)) (position-y (world-dog world))))
                  SCENE)
)

; takes an image, world and position changes in x and y and returns a world
(define (move-image image world x y)
  (cond
    [(equal? image DOG) (make-world
                          (keep-in-world DOG
                            (make-position
                              (position-x (world-cat world))
                              (position-y (world-cat world))
                            )
                          )
                          (keep-in-world DOG
                            (make-position
                              (+ x (position-x (world-dog world)))
                              (+ y (position-y (world-dog world)))
                            )
                          ))]
    [(equal? image CAT) (make-world
                          (keep-in-world CAT
                            (make-position
                              (+ x (position-x (world-cat world)))
                              (+ y (position-y (world-cat world)))
                            )
                          )
                          (keep-in-world CAT
                            (make-position
                              (position-x (world-dog world))
                              (position-y (world-dog world))
                            )
                          ))]
    [else world]
  )
  
)

(define (move world key)
  (cond
    ; left-right-up-down is the order
    ;;;; DOG ;;;;
    ; left
    [(key=? key "a") (move-image DOG world (* -1 DELTA) 0)]
    [(key=? key "d") (move-image DOG world DELTA        0)]
    [(key=? key "w") (move-image DOG world 0            (* -1 DELTA))]
    [(key=? key "s") (move-image DOG world 0            DELTA)]
    ;;;; CAT ;;;;
    [(key=? key "left")  (move-image CAT world (* -1 DELTA) 0)]
    [(key=? key "right") (move-image CAT world DELTA        0)]
    [(key=? key "up")    (move-image CAT world 0            (* -1 DELTA))]
    [(key=? key "down")  (move-image CAT world 0            DELTA)]
    [else world]
  )
)

(define (overlap? world)
  (if (images/overlap? CAT (world-cat world)
                       DOG (world-dog world))
      #true
      #false)
)

(define (finished world)
  (place-images (list (text "GAME OVER" 36 "red")
                      CAT
                      DOG
                      (text "The dog caught the cat!" 24 "black"))
                (list (make-posn ; game over
                        (floor (/ WIDTH 2))
                        (floor (/ WIDTH 4))
                      )
                      (make-posn ; cat
                        (floor (/ WIDTH 3))
                        (floor (/ WIDTH 2))
                      )
                      (make-posn ; dog
                        (floor (* 2 (/ WIDTH 3)))
                        (floor (/ WIDTH 2))
                      )
                      (make-posn ; other text
                        (floor (/ WIDTH 2))
                        (floor (* 3 (/ WIDTH 4)))
                      ))
                SCENE)
)

(define (main world)
  (big-bang world
            [to-draw render]
            [on-key move]
            [stop-when overlap? finished]

  )
)

(main
  (make-world
    ; CAT
    (make-position
      50 50
    )
    ; DOG
    (make-position
      150 150
    )
  )
)
