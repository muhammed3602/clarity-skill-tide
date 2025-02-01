;; Constants
(define-constant err-invalid-rating (err u100))
(define-constant err-not-participant (err u101))

;; Data structures
(define-map UserReputation
  { user: principal }
  {
    total-rating: uint,
    review-count: uint
  }
)

;; Public functions
(define-public (add-rating (user principal) (rating uint))
  (if (> rating u5)
    err-invalid-rating
    (let ((current-rep (default-to 
      { total-rating: u0, review-count: u0 }
      (map-get? UserReputation { user: user }))))
      (map-set UserReputation
        { user: user }
        {
          total-rating: (+ (get total-rating current-rep) rating),
          review-count: (+ (get review-count current-rep) u1)
        }
      )
      (ok true)
    )
  )
)

(define-read-only (get-reputation (user principal))
  (map-get? UserReputation { user: user })
)
