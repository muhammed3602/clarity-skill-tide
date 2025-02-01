;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))

;; Data structures
(define-map Skills 
  { skill-id: uint }
  { 
    owner: principal,
    title: (string-ascii 64),
    description: (string-utf8 256),
    lat: int,
    long: int,
    rating: uint,
    reviews: uint
  }
)

(define-map SwapRequests
  { request-id: uint }
  {
    requester: principal,
    skill-offered: uint,
    skill-wanted: uint,
    status: (string-ascii 20),
    location: (tuple (lat int) (long int))
  }
)

;; Storage
(define-data-var last-skill-id uint u0)
(define-data-var last-request-id uint u0)

;; Public functions
(define-public (create-skill (title (string-ascii 64)) 
                           (description (string-utf8 256))
                           (lat int)
                           (long int))
  (let ((new-id (+ (var-get last-skill-id) u1)))
    (map-insert Skills
      { skill-id: new-id }
      { 
        owner: tx-sender,
        title: title,
        description: description,
        lat: lat,
        long: long,
        rating: u0,
        reviews: u0
      }
    )
    (var-set last-skill-id new-id)
    (ok new-id)
  )
)

(define-public (create-swap-request (skill-offered uint)
                                  (skill-wanted uint)
                                  (lat int)
                                  (long int))
  (let ((new-id (+ (var-get last-request-id) u1)))
    (map-insert SwapRequests
      { request-id: new-id }
      {
        requester: tx-sender,
        skill-offered: skill-offered,
        skill-wanted: skill-wanted,
        status: "open",
        location: (tuple (lat lat) (long long))
      }
    )
    (var-set last-request-id new-id)
    (ok new-id)
  )
)

(define-read-only (get-skill (skill-id uint))
  (map-get? Skills {skill-id: skill-id})
)

(define-read-only (get-swap-request (request-id uint))
  (map-get? SwapRequests {request-id: request-id})
)
